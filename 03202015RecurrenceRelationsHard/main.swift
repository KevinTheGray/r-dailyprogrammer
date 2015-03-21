//
//  main.swift
//  03202015_RecursiveRelationHard
//
//  Created by Kevin Gray on 3/20/15.
//  Copyright (c) 2015 KTG. All rights reserved.
//

import Foundation

let args = getProgramData("03202015args.txt");

func add(a:Int, b:Int) -> Int { return a + b };
func mul(a:Int, b:Int) -> Int { return a * b };
func sub(a:Int, b:Int) -> Int { return a - b };
func div(a:Int, b:Int) -> Int { return a / b };
let mathFuncs = ["+": add, "*": mul, "-": sub, "/": div];

var terms : [Int?] = Array(count: args[args.count - 1].integerValue + 1, repeatedValue: nil);
for var i = args.count - 2; i > 0; --i {
  let termValues = args[i].componentsSeparatedByString(":");
  terms[termValues[0].integerValue] = termValues[1].integerValue;
}

for var i = 0; i < terms.count; ++i {
  var valueStack : [Int] = Array();
  for arg in args[0].componentsSeparatedByString(" ") {
    let arg = arg as NSString;
    if(arg.substringToIndex(1) == "(") {
      var valueIndex = i - Int((arg.substringWithRange(NSMakeRange(1, arg.length - 1)) as NSString).integerValue);
      if(valueIndex < 0 || terms[valueIndex] == nil) { valueStack = Array(); break; }
      valueStack.insert(terms[valueIndex]!, atIndex: 0);
    } else if(mathFuncs[arg] != nil) {
      var arg2 = valueStack.removeAtIndex(0); var arg1 = valueStack.removeAtIndex(0);
      valueStack.insert(mathFuncs[arg]!(arg1, arg2), atIndex: 0);
    }
    else {
      valueStack.insert(Int(arg.integerValue), atIndex: 0);
    }
  }
  if(valueStack.count == 1) { terms[i] = valueStack[0]; }
  if(terms[i] != nil) { println("Term \(i): \(terms[i]!)"); }
}


