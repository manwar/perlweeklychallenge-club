fun reversible(mx: Int): List<Int> {
    var o = ArrayList<Int>()
    for (n in 1..mx) {
        var t = n + n.toString().reversed().toInt()
        var q = true
        while (t > 0) {
            if (t % 2 == 0) {
                q = false
                break
            }
            t /= 10
        }
        if (q) {
            o.add(n)
        }
    }
    return o
}

fun main() {
    if (reversible(99) == listOf(10, 12, 14, 16, 18, 21, 23, 25, 27, 30,
                                 32, 34, 36, 41, 43, 45, 50, 52, 54, 61,
                                 63, 70, 72, 81, 90)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
