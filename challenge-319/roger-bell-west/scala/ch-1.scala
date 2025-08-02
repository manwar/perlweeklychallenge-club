
object Wordcount {
  def wordcount(a: List[String]): Int = {
    var ct = 0
    for (w <- a) {
      val d = w.charAt(0) match {
        case 'a' | 'e' | 'i' | 'o' | 'u' => 1
        case _ => {
          w.charAt(w.length - 1) match {
            case 'a' | 'e' | 'i' | 'o' | 'u' => 1
            case _ => 0
          }
        }
      }
      ct += d
    }
    ct
  }
  def main(args: Array[String]) {
    if (wordcount(List("unicode", "xml", "raku", "perl")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordcount(List("the", "weekly", "challenge")) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (wordcount(List("perl", "python", "postgres")) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
