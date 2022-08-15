import kotlin.math.*

fun r2qi (n: Int): String {
    return c2qi(n, 0)
}

fun c2qi (r0: Int, i0: Int): String {
    var l = ArrayList<ArrayList<Int>>()
    for (n0 in listOf(i0, r0)) {
        var n = n0
        var digits = ArrayList<Int>()
        while (n != 0) {
            var digit = n % -4
            n /= -4
            if (digit < 0) {
                digit += 4
                n += 1
            }
            digits.add(digit)
        }
        l.add(digits)
    }
    val ld = l[0].size - l[1].size
    if (ld < 0) {
        for (x in 1..-ld-1) {
            l[0].add(0,0)
        }
    } else if (ld > 1) {
        for (x in 1..ld) {
            l[1].add(0,0)
        }
    }
    var o = ""
    for (i in l[1].size-1 downTo 0) {
        for (b in listOf(0,1)) {
            if (l[b].size > i) {
                o += l[b][i]
            }
        }
    }
    return o
}

fun qi2r(n: String): Int {
    return qi2c(n)[0]
}

fun qi2c(n: String): List<Int> {
    var pow = 1
    var ri = 0
    var r = 0
    var i = 0
    for (ch in n.reversed().toList()) {
        // Work round a compiler bug apparently
        if (ri == 0) {
            r += (ch.digitToInt()) * pow
        } else {
            i += (ch.digitToInt()) * pow
        }
        ri += 1
        pow *= 2
        if (ri == 2) {
            ri = 0
            pow = -pow
        }
    }
    return listOf(r,i)
}

fun main() {
    if (r2qi(4) == "10300") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (qi2r("10300") == 4) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
