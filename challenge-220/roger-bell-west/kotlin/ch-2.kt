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

fun squared(a: Int): Int {
    return a * a
}

fun squareful(lst: List<Int>): List<List<Int>> {
    var results = mutableSetOf<List<Int>>()
    var squares = mutableSetOf<Int>()
    for (la in permute(lst)) {
        var squareful = true
        for (a in la.windowed(size = 2)) {
            val cs = a[0] + a[1]
            var mx = squared(squares.size)
            while (cs > mx) {
                mx = squared(squares.size + 1)
                squares.add(mx)
            }
            if (!squares.contains(cs)) {
                squareful = false
                break
            }
        }
        if (squareful) {
            results.add(la)
        }
    }
    return results.toList()
}

fun main() {

    if (squareful(listOf(1, 17, 8)) == listOf(listOf(1, 8, 17), listOf(17, 8, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (squareful(listOf(2, 2, 2)) == listOf(listOf(2, 2, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
