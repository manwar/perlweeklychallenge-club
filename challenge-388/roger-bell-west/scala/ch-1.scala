import scala.collection.mutable.ListBuffer
import scala.collection.mutable

object Dyckwords {
  def dyckwords(order: Int): List[String] = {
    var out = new ListBuffer[String]
    var queue = mutable Queue[String]("")
    while (queue.size > 0) {
      val st = queue.dequeue
      val dcount = st.toList.filter(c => c == 'D').size
      if (st.length == order * 2) {
        if (dcount == order) {
          out += st
        }
      } else {
        if (dcount * 2 < st.length) {
          queue += (st + "D")
        }
        queue += (st + "U")
      }
    }
    return out.toList
  }
  def main(args: Array[String]) {
    if (dyckwords(1) == List("UD")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dyckwords(2) == List("UDUD", "UUDD")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dyckwords(3) == List("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dyckwords(0) == List("")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (dyckwords(4) == List("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
