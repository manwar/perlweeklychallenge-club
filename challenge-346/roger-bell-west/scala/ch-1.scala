
object Longestparenthesis {
  def longestparenthesis(aa: String): Int = {
    val a = aa.toList
    var ml = 0
    for (l <- 0 until a.size) {
      for (r <- l until a.size) {
        var depth = 0
        var valid = true
        for (i <- l to r) {
          if (a(i) == '(') {
            depth += 1;
          } else {
            depth -= 1
            if (depth < 0) {
              valid = false
            }
          }
        }
        if (depth != 0) {
          valid = false
        }
        if (valid) {
          ml = List(ml, r - l + 1).max
        }
      }
    }
    ml
  }
  def main(args: Array[String]) {
    if (longestparenthesis("(()())") == 6) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestparenthesis(")()())") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestparenthesis("((()))()(((()") == 8) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestparenthesis("))))((()(") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestparenthesis("()(()") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
