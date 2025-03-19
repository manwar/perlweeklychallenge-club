
object Brokenkeys {
  def brokenkeys(name: String, typed: String): Boolean = {
    val nt = name.toList
    val tt = typed.toList
    var ni = 0
    var ti = 0
    var ret = true
    var inloop = true
    while (inloop) {
      if (nt(ni) != tt(ti)) {
        inloop = false
        ret = false
      } else if (tt == tt.length - 1) {
        inloop = false
      } else {
        if (ni < nt.length - 1 && nt(ni + 1) == nt(ni)) {
          ni += 1
        } else {
          while (ti < tt.length && tt(ti) == nt(ni)) {
            ti += 1
          }
          if (ti == tt.length) {
            inloop = false
          } else {
            ni += 1
          }
        }
      }
    }
    ret
  }
  def main(args: Array[String]) {
    if (brokenkeys("perl", "perrrl")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeys("raku", "rrakuuuu")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (!brokenkeys("python", "perl")) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (brokenkeys("coffeescript", "cofffeescccript")) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
