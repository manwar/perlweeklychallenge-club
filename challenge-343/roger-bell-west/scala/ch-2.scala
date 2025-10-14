import scala.collection.mutable.ListBuffer

object Championteam {
  def championteam(a: List[List[Int]]): Int = {
    var maxw = 0
    var teamw = new ListBuffer[Int]
    for ((w, i) <- a.zipWithIndex) {
      val wins = w.sum
      if (wins > maxw) {
        teamw = new ListBuffer[Int]
        maxw = wins
      }
      if (wins == maxw) {
        teamw += i
      }
    }
    if (teamw.size == 1) {
      teamw(0)
    } else {
      var bestt = teamw(0)
      for (rt <- teamw) {
        if (a(rt)(bestt) == 1) {
          bestt = rt
        }
      }
      bestt
    }
  }
  def main(args: Array[String]) {
    if (championteam(List(List(0, 1, 1), List(0, 0, 1), List(0, 0, 0))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (championteam(List(List(0, 1, 0, 0), List(0, 0, 0, 0), List(1, 1, 0, 0), List(1, 1, 1, 0))) == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (championteam(List(List(0, 1, 0, 1), List(0, 0, 1, 1), List(1, 0, 0, 0), List(0, 0, 1, 0))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (championteam(List(List(0, 1, 1), List(0, 0, 0), List(0, 1, 0))) == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (championteam(List(List(0, 0, 0, 0, 0), List(1, 0, 0, 0, 0), List(1, 1, 0, 1, 1), List(1, 1, 0, 0, 0), List(1, 1, 0, 1, 0))) == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
