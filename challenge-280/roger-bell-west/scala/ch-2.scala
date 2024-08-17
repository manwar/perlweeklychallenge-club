
object Countasterisks {
  def countasterisks(a: String): Int = {
    var out = 0
    var active = true
    for (c <- a.toList) {
      c match {
        case '|' => { active = !active }
        case '*' => {
          if (active) {
            out += 1
          }
        }
        case _ => { }
      }
    }
    return out
  }
  def main(args: Array[String]) {
    if (countasterisks("p|*e*rl|w**e|*ekly|") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countasterisks("perl") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (countasterisks("th|ewe|e**|k|l***ych|alleng|e") == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
