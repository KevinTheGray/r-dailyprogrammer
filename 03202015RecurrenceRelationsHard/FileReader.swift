// Pretty much just use it to get arguments

import Foundation

func getProgramData(fileName: String) -> [NSString] {
    // Find the document directory
    if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
        // Documents directory
        let dir = dirs[0];
        // Configure file directory
        let filePath = dir.stringByAppendingPathComponent("/DPArgs/" + fileName);
        let fileContents = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil);
        if(fileContents != nil) {
            return (fileContents!.componentsSeparatedByString("\n"));
        }
    }
    return [NSString]();
}