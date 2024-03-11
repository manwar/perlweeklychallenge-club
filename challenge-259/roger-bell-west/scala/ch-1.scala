import java.time.LocalDate
import java.time.format.DateTimeFormatter

object Bankingdayoffset {
  def bankingdayoffset(start: String, offset: Int, bankholidays: List[String]): String = {
    val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
    val bh = bankholidays.map(d => LocalDate.parse(d, formatter)).toSet
    var current = LocalDate.parse(start, formatter)
    for (i <- 1 to offset) {
      current = current.plusDays(1)
      while (bh.contains(current) || current.getDayOfWeek().getValue() > 5) {
        current = current.plusDays(1)
      }
    }
    return current.format(formatter)
  }
  def main(args: Array[String]) {
    if (bankingdayoffset("2018-06-28", 3, List("2018-07-03")) == "2018-07-04") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (bankingdayoffset("2018-06-28", 3, List()) == "2018-07-03") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
