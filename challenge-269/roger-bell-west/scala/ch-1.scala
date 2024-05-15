
object Bitwiseor {
  def bitwiseor(a: List[Int]): Boolean = {
    a.filter(n => n % 2 == 0).length >= 2
  }
  def main(args: Array[String]) {
    if (bitwiseor(List(1, 2, 3, 4, 5))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (bitwiseor(List(2, 3, 8, 16))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!bitwiseor(List(1, 2, 5, 7, 9))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
