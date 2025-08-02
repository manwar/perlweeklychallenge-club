
object Noconnection {
  def noconnection(a: List[List[Char]]): Char = {
    val os = a.map( n => n(0) ).toSet
    val is = a.map( n => n(1) ).toSet
    is.diff(os).toList(0)
  }
  def main(args: Array[String]) {
    if (noconnection(List(List('B', 'C'), List('D', 'B'), List('C', 'A'))) == 'A') {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (noconnection(List(List('A', 'Z'))) == 'Z') {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
