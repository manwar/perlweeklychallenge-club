fun fivenumber(n0: List<Double>): ArrayList<Double> {
    var n = ArrayList(n0)
    n.sort()
    val nl = n.size - 1
    var o = arrayListOf(n[0])
    for (quartile in 1..3) {
        val bx = quartile * nl
        val base = bx / 4
        var v = n[base]
        if (bx % 4 != 0) {
            v = (n[base] + n[base+1]) / 2.0
        }
        o.add(v)
    }
    o.add(n[n.size - 1])
    return o
}

fun main() {
    if (fivenumber(listOf(0.0, 0.0, 1.0, 2.0, 63.0, 61.0, 27.0, 13.0)) ==
            listOf(0.0, 0.5, 7.5, 44.0, 63.0)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
