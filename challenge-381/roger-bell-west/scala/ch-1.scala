import scala.collection.mutable

object Samerowcolumn {
  def samerowcolumn(a: List[List[Int]]): Boolean = {
    var ret = true
    for (row <- a) {
      var notfound = (1 to row.size).toSet
      for (n <- row) {
        notfound -= n
      }
      if (notfound.size > 0) {
        ret = false
      }
    }
    for (coln <- 0 until a(0).size) {
      var notfound = (1 to a.size).toSet
      for (row <- a) {
        notfound -= row(coln)
      }
      if (notfound.size > 0) {
        ret = false
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (samerowcolumn(List(List(1, 2, 3, 4), List(2, 3, 4, 1), List(3, 4, 1, 2), List(4, 1, 2, 3)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (samerowcolumn(List(List(1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!samerowcolumn(List(List(1, 2, 5), List(5, 1, 2), List(2, 5, 1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!samerowcolumn(List(List(1, 2, 3), List(1, 2, 3), List(1, 2, 3)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!samerowcolumn(List(List(1, 2, 3), List(3, 1, 2), List(3, 2, 1)))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
