import kotlin.math.*

fun ls(base: Int): String {
    var max: Long=0
    for (i in base-1 downTo 0) {
        max *= base
        max += i
    }
    var t=sqrt(max.toDouble()).toLong()
    val digits="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    while (true) {
        var s=t*t
        var v=true
        var c=IntArray(base) {_ -> 0}
        var dg: String=""
        while (s > 0) {
            val d=(s % base).toInt()
            c[d] += 1
            if (c[d] > 1) {
                v=false
                break
            }
            s /= base
            dg = digits[d] + dg
        }
        if (v) {
            return dg
        }
        t -= 1
    }
}

fun main() {
  if (ls(2) == "1") {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")

  if (ls(4) == "3201") {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")

  if (ls(10) == "9814072356") {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")

  if (ls(12) == "B8750A649321") {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
