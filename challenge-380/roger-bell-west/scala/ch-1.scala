import scala.collection.mutable

object Sumoffrequencies {
  def counterify(a: List[Char]): Map[Char, Int] = {
    var cc = mutable.Map.empty[Char, Int].withDefaultValue(0)
    for (x <- a) {
      cc += (x -> (cc(x) + 1))
    }
    cc.toMap
  }
  def sumoffrequencies(a: String): Int = {
    var vw = 0
    var cn = 0
    val cc = counterify(a.toList)
    var cv = cc.values.toList.sortWith(_ > _)
    for (n <- cv) {
      for ((c, ni) <- cc) {
        if (ni == n) {
          if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            if (vw == 0) {
              vw = n
            }
          } else {
            if (cn == 0) {
              cn = n
            }
          }
        }
      }
    }
    vw + cn
  }
  def main(args: Array[String]) {
    if (sumoffrequencies("banana") == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sumoffrequencies("teestett") == 7) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sumoffrequencies("aeiouuaa") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sumoffrequencies("rhythm") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (sumoffrequencies("x") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
