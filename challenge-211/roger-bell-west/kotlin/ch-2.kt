fun combinations(arr: List<Int>, k: Int): List<List<Int>> {
    var c = ArrayList<Int>()
    for (i in 0 .. k-1) {
        c.add(i)
    }
    c.add(arr.size)
    c.add(0)
    var out = ArrayList<List<Int>>()
    while (true) {
        var inner = ArrayList<Int>()
        for (i in k-1 downTo 0) {
            inner.add(arr[c[i]])
        }
        out.add(inner.toList())
        var j = 0
        while (c[j] + 1 == c[j + 1]) {
            c[j] = j
            j += 1
        }
        if (j >= k) {
            break
        }
        c[j] += 1
    }
    return out.toList();
}

fun splitsameaverage(a: List<Int>): Boolean {
    val ss = a.sum()
    val ml = a.size
    val mx = ml / 2
    var ssa = false
    for (n in 1 .. mx) {
        for (c in combinations(a, n)) {
            var ca = c.sum()
            if (ca.toFloat() / n.toFloat() == (ss - ca).toFloat() / (ml - n).toFloat()) {
                ssa = true
                break
            }
        }
        if (ssa) {
            break
        }
    }
    return ssa
}

fun main() {
    
    if (splitsameaverage(listOf(1, 2, 3, 4, 5, 6, 7, 8))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!splitsameaverage(listOf(1, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (splitsameaverage(listOf(1, 2, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
