import java.time.Duration
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

object Dayoftheyear {
  def dayoftheyear(a: String): Int = {
    val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
    return LocalDate.parse(a, formatter).getDayOfYear()
  }
  def main(args: Array[String]) {
    if (dayoftheyear("2025-02-02") == 33) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dayoftheyear("2025-04-10") == 100) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dayoftheyear("2025-09-07") == 250) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
