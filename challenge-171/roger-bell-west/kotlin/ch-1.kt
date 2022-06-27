import kotlin.math.*

fun abundant(n: Int): Boolean {
    if (n==1) {
        return false
    }
    var ff = 1
    var s = Math.sqrt(n.toDouble()).toInt()
    if (s * s == n) {
        ff += s
        s -= 1
    }
    for (pf in 2..s) {
        if (n % pf == 0) {
            ff += pf
            ff += n / pf
            if (ff > n) {
                return true
            }
        }
    }
    return false
}

fun oddabundant(ct: Int): List<Int> {
    var n = 1
    var o = ArrayList<Int>()
    while (true) {
        if (abundant(n)) {
            o.add(n)
            if (o.size >= ct) {
                break
            }
        }
        n += 2
    }
    return o
}

fun main() {
    if (oddabundant(20) == listOf(945, 1575, 2205, 2835, 3465, 4095,
                                  4725, 5355, 5775, 5985, 6435, 6615,
                                  6825, 7245, 7425, 7875, 8085, 8415,
                                  8505, 8925)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
