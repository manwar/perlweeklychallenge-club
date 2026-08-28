
object Secretsanta {
  def secretsanta(n: Int): Int = {
    n match {
      case 0 => 1
      case 1 => 0
      case _ => (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2));
    }
  }
  def main(args: Array[String]) {
    if (secretsanta(1) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secretsanta(2) == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secretsanta(3) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secretsanta(4) == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secretsanta(5) == 44) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
