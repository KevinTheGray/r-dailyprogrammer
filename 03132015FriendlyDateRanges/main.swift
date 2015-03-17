import Foundation

func getDayAppendage(day:Int) -> String {
  if((day >= 10 && day <= 20) || (day%10 > 3)) {
    return "th";
  }
  let dayThings = ["th", "st", "nd", "rd"];
  return dayThings[day%10%4];
}

extension NSDate
{
  convenience
  init(dateString:String) {
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = "yyyy-MM-dd"
    dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    let d = dateStringFormatter.dateFromString(dateString)
    self.init(timeInterval:0, sinceDate:d!)
  }
}


// Get the current year.
let date = NSDate()
let calendar = NSCalendar.currentCalendar()
let components = calendar.components(.CalendarUnitYear, fromDate: date)
let currentYear = components.year;

let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
let YEAR = 0; let MONTH = 1; let DAY = 2;
let args = getProgramData("031315args.txt");
for dateRange in args {
  // Break the range into two dates
  let dates = dateRange.componentsSeparatedByString(" ");
  let startDate = dates[0].componentsSeparatedByString("-");
  let endDate   = dates[1].componentsSeparatedByString("-");
  let startMonth = ((startDate[MONTH]) as String).toInt()! - 1;
  let startDay = ((startDate[DAY]) as String).toInt()!;
  let startYear = ((startDate[YEAR]) as String).toInt()!;
  let endMonth = ((endDate[MONTH]) as String).toInt()! - 1;
  let endDay = ((endDate[DAY]) as String).toInt()!;
  let endYear = ((endDate[YEAR]) as String).toInt()!;
  let m1 = months[startMonth]; let m2 = months[endMonth];
  let d1 = "\(startDay)" + getDayAppendage(startDay);
  let d2 = "\(endDay)" + getDayAppendage(endDay);
  
  // Same year
  if(startYear == endYear) {
    // Current Year
    if(startMonth == endMonth && startDay == endDay) {
      println("\(m2) \(d2), \(endYear)");
    }
    else if(startYear == currentYear) {
      println("\(m1) \(d1) - \(m2) \(d2)");
    }
    else {
      println("\(m1) \(d1) - \(m2) \(d2), \(endYear)");
    }
  }
  else if(startYear == currentYear) {
    // Get the time between dates
    let date0 = NSDate(dateString: dates[0] as String);
    let date1 = NSDate(dateString: dates[1] as String);
    let interval = date1.timeIntervalSinceDate(date0);
    // I guess I could check for leap year here, but I'm not going to,
    if(interval < 31557600.0) {
      println("\(m1) \(d1) - \(m2) \(d2)");
    }
    else {
      println("\(m1) \(d1), \(startYear) - \(m2) \(d2), \(endYear)");
    }
  }
  else {
    println("\(m1) \(d1), \(startYear) - \(m2) \(d2), \(endYear)");
  }
}

