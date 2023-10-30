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

fun unequaltriplets(utl: List<Int>): Int {
    var utc = mutableMapOf<Int, Int>().withDefault({0})
    for (n in utl) {
        utc.set(n, utc.getValue(n) + 1);
    }
    val kl = utc.keys.toList()
    if (kl.size < 3) {
        return 0
    }
    var out = 0
    for (c in combinations(kl, 3)) {
        out += utc.getValue(c[0]) * utc.getValue(c[1]) * utc.getValue(c[2]);
    }
    return out
}

fun main() {

    if (unequaltriplets(listOf(4, 4, 2, 4, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (unequaltriplets(listOf(1, 1, 1, 1, 1)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (unequaltriplets(listOf(4, 7, 1, 10, 7, 4, 1, 1)) == 28) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
