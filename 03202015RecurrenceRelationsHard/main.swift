//
//  main.swift
//  03202015_RecursiveRelationHard
//
//  Created by Kevin Gray on 3/20/15.
//  Copyright (c) 2015 KTG. All rights reserved.
//

import Foundation

let args = getProgramData("03202015args.txt");
// Create an array of n optional ints
var terms : [Int?] = Array(count: args[args.count - 1].integerValue, repeatedValue: nil);
for var i = args.count - 2; i > 0; --i {
  let termValues = args[i].componentsSeparatedByString(":");
  terms[termValues[0].integerValue] = termValues[1].integerValue;
}

for var i = 0; i < terms.count; ++i {
  if(terms[i] != nil) { println("Term \(i): \(terms[i]!)"); }
}


