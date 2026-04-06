import scala.collection.mutable.ListBuffer

object Conflictevents {
  def parsetime(t: String): Int = {
    val p = t.split(':')
    return p(0).toInt * 60 + p(1).toInt
  }

  def conflictevents(a: List[String], b: List[String]): Boolean = {
    var r = new ListBuffer[List[List[Int]]]
    for (t <- List(a, b)) {
      val st = parsetime(t(0))
      val en = parsetime(t(1))
      if (st < en) {
        r += List(List(st, en - 1))
      } else {
        r += List(
          List( st, 1440 - 1 ),
          List( 0, en - 1 )
        )
      }
    }
    var ret = false
    for (ra <- r(0)) {
      for (rb <- r(1)) {
        if (ra(0) <= rb(1) && rb(0) <= ra(1)) {
          ret = true
        }
      }
    }
    ret
  }

  def main(args: Array[String]) {
    if (conflictevents(List("10:00", "12:00"), List("11:00", "13:00"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!conflictevents(List("09:00", "10:30"), List("10:30", "12:00"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (conflictevents(List("14:00", "15:30"), List("14:30", "16:00"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!conflictevents(List("08:00", "09:00"), List("09:01", "10:00"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (conflictevents(List("23:30", "00:30"), List("00:00", "01:00"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
