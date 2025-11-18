
object Converttime {

  def hm2m(a: String): Int = {
    val p = a.split(":")
    return Integer.parseInt(p(0)) * 60 + Integer.parseInt(p(1))
  }

  def converttime(ssrc: String, ttgt: String): Int = {
    val src = hm2m(ssrc)
    var tgt = hm2m(ttgt)
    if (tgt < src) {
      tgt += 24 * 60
    }
    var delta = tgt - src
    var oc = 0
    for (op <- List(60, 15, 5, 1)) {
      oc += delta / op
      delta %= op
    }
    oc
  }

  def main(args: Array[String]) {
    if (converttime("02:30", "02:45") == 1) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (converttime("11:55", "12:15") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (converttime("09:00", "13:00") == 4) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (converttime("23:45", "00:30") == 3) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (converttime("14:20", "15:25") == 2) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
