
object Taxamount {
  def taxamount(income: Int, brackets: List[List[Int]]): Double = {
    var tax = 0
    var lastbracket = 0
    for (bracket <- brackets) {
      if (income > lastbracket) {
        tax += (List(income, bracket(0)).min - lastbracket) * bracket(1)
      }
      lastbracket = bracket(0)
    }
    tax.toDouble / 100.0
  }
  def main(args: Array[String]) {
    if (taxamount(10, List(List(3, 50), List(7, 10), List(12, 25))) == 2.65) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (taxamount(2, List(List(1, 0), List(4, 25), List(5, 50))) == 0.25) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (taxamount(0, List(List(2, 50))) == 0.0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
