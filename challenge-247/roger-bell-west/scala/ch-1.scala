import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Secretsanta {
  def secretsanta(name: List[String]): Boolean = {
    val family = name.map(n => n.split(" ").last)
    var receivers = (0 until name.length).toSet
    var gifting = new ListBuffer[List[String]]
    for (giver <- 0 until name.length) {
      var done = false
      var r = 0
      for (recipient <- receivers) {
        if (!done && family(giver) != family(recipient)) {
          r = recipient
          done = true
        }
      }
      if (!done) {
        for (recipient <- receivers) {
          if (!done && giver != recipient) {
            r = recipient
            done = true
          }
        }
      }
      receivers -= r
      gifting += List(name(giver), name(r))
    }
    for (p <- gifting) {
      print(p(0))
      print(" -> ")
      println(p(1))
    }
    println("")
    return true;
  }
  def main(args: Array[String]) {
    if (secretsanta(List("Mr. Wall", "Mrs. Wall", "Mr. Anwar", "Mrs. Anwar", "Mr. Conway", "Mr. Cross"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (secretsanta(List("Mr. Wall", "Mrs. Wall", "Mr. Anwar"))) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")
  }
}
