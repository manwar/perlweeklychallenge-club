
object Acronym {
  def acronym(strs: List[String], chk: String): Boolean = {
    strs.map(x => x.substring(0, 1)).mkString("").toLowerCase() ==
    chk.toLowerCase()
  }
  def main(args: Array[String]) {
      if (acronym(List("Perl", "Python", "Pascal"), "ppp")) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (!acronym(List("Perl", "Raku"), "rp")) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (acronym(List("Oracle", "Awk", "C"), "oac")) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
