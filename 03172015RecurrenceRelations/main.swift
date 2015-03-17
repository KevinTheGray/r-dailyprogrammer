//http://www.reddit.com/r/dailyprogrammer/comments/2z68di/20150316_challenge_206_easy_recurrence_relations/

    import Foundation

    let args = getProgramData("03172015args.txt");

    func add(a:Int, b:Int) -> Int { return a + b };
    func mul(a:Int, b:Int) -> Int { return a * b };
    func sub(a:Int, b:Int) -> Int { return a - b };
    func div(a:Int, b:Int) -> Int { return a / b };
    let mathFuncs = ["+": add, "*": mul, "-": sub, "/": div];

    let baseValue = Int((args[1] as NSString).intValue);
    let termNumber = Int((args[2] as NSString).intValue);

    let operations = args[0].componentsSeparatedByString(" ");
    println("Term 0: \(baseValue)");
    var result = baseValue;
    for var i = 1; i <= termNumber; i++ {
      for op in operations {
        let intVal = Int(((op.substringWithRange(NSMakeRange(1,op.length - 1)) as NSString).intValue));
        result = (mathFuncs[op.substringWithRange(NSMakeRange(0, 1))])!(result,intVal);
      }
      println("Term \(i): \(result)");
    }
