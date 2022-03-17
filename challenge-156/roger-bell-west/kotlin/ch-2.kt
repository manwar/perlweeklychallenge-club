import kotlin.math.*

fun divisors(n: Int): ArrayList<Int> {
    var ff=ArrayList<Int>(1)
    if (n==1) {
        return ff
    }
    var s = Math.sqrt(n.toDouble()).toInt()
    if (s * s == n) {
        ff.add(s)
        s -= 1
    }
    for (pf in 2..s) {
        if (n % pf == 0) {
            ff.add(pf)
            ff.add(n / pf)
        }
    }
    return ff
}

fun is_weird(n: Int): Boolean {
    val dd=divisors(n)
    if (dd.sum() <= n) {
        return false
    }
    for (mask in 1..(1 shl dd.size)-1) {
        var ss=0
        for ((i,d) in dd.withIndex()) {
            if (mask and (1 shl i) > 0) {
                ss += d
                if (ss > n) {
                    break
                }
            }
            if (ss == n) {
                return false
            }
        }
    }
    return true
}

fun main() {
    if (!is_weird(12)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (!is_weird(13)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (is_weird(70)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
