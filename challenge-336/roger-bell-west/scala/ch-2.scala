import scala.collection.mutable.ListBuffer

object Finalscore {
  def finalscore(a: List[String]): Int = {
    var p = new ListBuffer[Int]
    for (n <- a) {
      n match {
        case "C" => {
          p = p.dropRight(1)
        }
        case "D" => {
          p += 2 * p.last
        }
        case "+" => {
          p += p(p.size - 2) + p(p.size - 1)
        }
        case _ => {
          p += n.toInt
        }
      }
    }
    p.sum
  }
  def main(args: Array[String]) {
    if (finalscore(List("5", "2", "C", "D", "+")) == 30) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finalscore(List("5", "-2", "4", "C", "D", "9", "+", "+")) == 27) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finalscore(List("7", "D", "D", "C", "+", "3")) == 45) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finalscore(List("-5", "-10", "+", "D", "C", "+")) == -55) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (finalscore(List("3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+")) == 128) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
