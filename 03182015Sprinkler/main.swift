//
//  main.swift
//  03182015_CropSprinkler
//
//  Created by Kevin Gray on 3/17/15.
//  Copyright (c) 2015 KTG. All rights reserved.
//

import Foundation

struct Crop {
  var x : Int; var y : Int;
}

let args = getProgramData("03182015DPArgs.txt")
let infoArgs = args[0].componentsSeparatedByString(" ");
// Get the height, width, and radius.
let h = (infoArgs[0] as NSString).integerValue; let w = (infoArgs[1] as NSString).integerValue;
let r = (infoArgs[2] as NSString).integerValue; let r2 = r * r;
// Find all of the crops, ignore the empty spots
var crops : Array<Crop> = [];
for var i = 1; i < args.count; i++ {
  var j = 0;
  for character in args[i] as String {
    if(character == "x") {
      crops.append(Crop(x: j, y: i - 1));
    }
    j++;
  }
}
// Compare each point against the rest of the crops.
var bestPos = Crop(x: 0, y: 0);
var bestCount = 0;
for var y = 0; y < h; y++ {
  for var x = 0; x < w; x++ {
    var count = 0;
    for crop in crops {
      if(crop.x == x && crop.y == y) {
        continue;
      }
      
      let d = (crop.x - x) * (crop.x - x) + (crop.y - y) * (crop.y - y);
      if (d <= r2) {
        ++count;
      }
      if(count > bestCount) {
        bestCount = count;
        bestPos = Crop(x: x, y: y);
      }
    }
  }
}

// Print the map.
for var y = 0; y < h; y++ {
  for var x = 0; x < w; x++ {
    let d = (bestPos.x - x) * (bestPos.x - x) + (bestPos.y - y) * (bestPos.y - y);
    if(crops.count > 0 && crops[0].x == x && crops[0].y == y) {
      if(!(x == bestPos.x && y == bestPos.y)) {
        print("x");
      }
      else {
        print("O");
      }
      crops.removeAtIndex(0);
    }
    else if (x == bestPos.x && y == bestPos.y) {
      print("O");
    }
    else if(d <= r2) {
      print("~");
    }
    else {
      print(".");
    }
  }
  println();
}
println("Best Position: (\(bestPos.x), \(bestPos.y))");

