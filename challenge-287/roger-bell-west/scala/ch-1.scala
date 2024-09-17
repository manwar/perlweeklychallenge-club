import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Strongpassword {
  def strongpassword(a: String): Int = {
    var ctypes = mutable.Map.empty[Char, Int].withDefaultValue(0)
    var reps = 0
    var rep = 0
    var old = '@'
    var changes = new ListBuffer[Int]
    for ((c, i) <- a.zipWithIndex) {
      if (i > 0 && c == old) {
        rep += 1
        if (rep >= 2) {
          reps += 1
        }
      } else {
        rep = 0
        old = c
      }
      var t = 'n'
      if (c >= 'A' && c <= 'Z') {
        t = 'u'
      } else if (c >= 'a' && c <= 'z') {
        t = 'l'
      } else if (c >= '0' && c <= '9') {
        t = 'd'
      }
      ctypes += (t -> (ctypes(t) + 1))
    }
    changes.append(reps)
    ctypes.remove('n')
    var k = ctypes.keys.size
    if (k < 3) {
      var spare = ctypes.values.reduce((x, y) => x + y) - k
      if (spare < 0) {
        changes.append(-spare)
      }
    }
    if (a.length < 6) {
      changes.append(6 - a.length)
    }
    changes.max
  }

  def main(args: Array[String]) {
    if (strongpassword("a") == 5) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (strongpassword("aB2") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (strongpassword("PaaSW0rd") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (strongpassword("Paaasw0rd") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (strongpassword("aaaaa") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
