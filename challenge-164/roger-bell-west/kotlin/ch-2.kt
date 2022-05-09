
fun ssd(n0: Int): Int {
    var n = n0
    var out = 0
    while (n > 0) {
        val d = n % 10
        out += d * d
        n /= 10
    }
    return out
}

fun happy(ct: Int): ArrayList<Int> {
    var hm = mutableMapOf<Int, Boolean>(1 to true)
    var c = 0
    var out = ArrayList<Int>()
    while (true) {
        c += 1
        if (!hm.contains(c)) {
            var v = c
            var ss = mutableSetOf<Int>(v)
            var h: Boolean
            while (true) {
                if (hm.contains(v)) {
                    h = hm[v]!!
                    break
                } else {
                    v = ssd(v)
                    if (ss.contains(v)) {
                        h = false
                        break
                    }
                    ss.add(v)
                }
            }
            ss.map { hm[it] = h }
        }
        if (hm[c]!!) {
            out.add(c)
            if (out.size >= ct) {
                break
            }
        }
    }
    return out
}

fun main() {
    if (happy(8) == listOf(1, 7, 10, 13, 19, 23, 28, 31)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
