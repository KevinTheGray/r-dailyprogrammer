//
//  main.swift
//  03232015_DNASequence
//
//  Created by Kevin Gray on 3/22/15.
//  Copyright (c) 2015 KTG. All rights reserved.
//

import Foundation

let args = getProgramData("03232015DPArgs.txt")[0].componentsSeparatedByString(" ") as [String];
let DNAMap = ["A":"T", "T":"A", "C":"G", "G":"C"];
for arg in args { print("\(DNAMap[arg]!) "); }
