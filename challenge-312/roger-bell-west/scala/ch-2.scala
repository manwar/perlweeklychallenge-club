import scala.collection.mutable

object Ballsandboxes {
  def ballsandboxes(a: String): Int = {
    var boxes = mutable.Map.empty[Int, mutable.Set[Char]]
    var colour = '@'
    for ((c, i) <- a.toList.zipWithIndex) {
      if (i % 2 == 0) {
        colour = c
      } else {
        val boxid = c.asDigit
        var s = mutable.Set.empty[Char]
        if (boxes.contains(boxid)) {
          s = boxes(boxid)
        }
        s += colour
        boxes += (boxid -> s)
      }
    }
    boxes.values.filter{x => x.size >= 3}.size
  }

  def main(args: Array[String]) {
    if (ballsandboxes("G0B1R2R0B0") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (ballsandboxes("G1R3R6B3G6B1B6R1G3") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (ballsandboxes("B3B2G1B3") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
