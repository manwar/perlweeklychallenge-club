
object Percentageofcharacter {
  def percentageofcharacter(a: String, c: Char): Int = {
    val d = a.length
    val n = 100 * a.filter(x => x == c).size
    (n + d / 2) / d
  }
  def main(args: Array[String]) {
    if (percentageofcharacter("perl", 'e') == 25) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (percentageofcharacter("java", 'a') == 50) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (percentageofcharacter("python", 'm') == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (percentageofcharacter("ada", 'a') == 67) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (percentageofcharacter("ballerina", 'l') == 22) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (percentageofcharacter("analitik", 'k') == 13) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
