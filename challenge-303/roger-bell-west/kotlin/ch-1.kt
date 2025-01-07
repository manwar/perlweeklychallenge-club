fun permute(aa: List<Int>): ArrayList<List<Int>> {
    var a = ArrayList<Int>()
    for (i in aa) {
        a.add(i)
    }
    var out = ArrayList<List<Int>>()
    val n = a.size
    var c = ArrayList<Int>();
    for (i in 0..n-1) {
        c.add(0)
    }
    out.add(a.toList())
    var i = 0
    while (true) {
        if (i >= n) {
            break
        }
        if (c[i] < i) {
            if (i % 2 == 0) {
                val tmp = a[0]
                a[0] = a[i]
                a[i] = tmp
            } else {
                val tmp = a[c[i]]
                a[c[i]] = a[i]
                a[i] = tmp
            }
            out.add(a.toList())
            c[i] += 1
            i = 0
        } else {
            c[i] = 0
            i += 1
        }
    }
    return out
}

fun concatenate(a: List<Int>): Int {
    val ax = a.map{it.toString()}
    return ax.joinToString("").toInt()
}

fun threedigitseven(a: List<Int>): List<Int> {
    var s = mutableSetOf<Int>()
    for (mask in 1 .. (1 shl a.size)-1) {
        var pl = ArrayList<Int>()
        a.forEachIndexed{i, v ->
                             if (mask and (1 shl i) > 0) {
                                 pl.add(v)
                             }
        }
        for (px in permute(pl.toList())) {
            val c = concatenate(px)
            if (c >= 100 && c <= 999 && c % 2 == 0) {
                s.add(c)
            }
        }
    }
    return s.toList().sorted()
}

fun main() {

    if (threedigitseven(listOf(2, 1, 3, 0)) == listOf(102, 120, 130, 132, 210, 230, 302, 310, 312, 320)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (threedigitseven(listOf(2, 2, 8, 8, 2)) == listOf(222, 228, 282, 288, 822, 828, 882)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
