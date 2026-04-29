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
    return out.toList()
}

fun subsetequilibrium(a: List<Int>): List<List<Int>> {
    var out = ArrayList<List<Int>>()
    val b = a.withIndex().map { (i, x) -> x - i - 1 }.toList()
    val ix = (0 .. b.size - 1).toList()
    for (n in 1 .. b.size - 1) {
        for (iyx in combinations(ix, n)) {
            val iy = iyx.sorted()
            val bp = iy.map { i -> b[i] }.sum()
            if (bp == 0) {
                val ap = iy.map{i -> a[i]}.toList()
                out += ap
            }
        }
    }
    val customComparator = Comparator {
        i: List<Int>, j: List<Int> ->
            val kx = listOf(i.size, j.size).minOrNull()!!
        var k = 0
        while (k < kx - 1) {
            if (i[k] == j[k]) {
                k += 1
            } else {
                break;
            }
        }
        val cmp = i[k] - j[k]
        if (cmp < 0) {
            -1
        } else if (cmp > 0) {
            1
        } else {
            0
        }
    }
    return out.sortedWith(customComparator).toList()
}

fun main() {

    if (subsetequilibrium(listOf(2, 1, 4, 3)) == listOf(listOf(1, 4), listOf(2, 1), listOf(2, 3), listOf(4, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (subsetequilibrium(listOf(3, 0, 3, 0)) == listOf(listOf(3), listOf(3, 0), listOf(3, 0, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (subsetequilibrium(listOf(5, 1, 1, 1)) == listOf(listOf(5, 1, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (subsetequilibrium(listOf(3, -1, 4, 2)) == listOf(listOf(3, -1, 4), listOf(3, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (subsetequilibrium(listOf(10, 20, 30, 40)) == emptyList<List<Int>>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
