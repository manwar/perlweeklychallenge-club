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

fun largestofthree(digits: List<Int>): Int {
    val ordered = digits.sorted()
    var mx = 0
    for (n in ordered.size - 1 downTo 0) {
        for (c in combinations(ordered, n + 1)) {
            var t = 0
            for (d in c) {
                t *= 10
                t += d
            }
            if (t > mx && t % 3 == 0) {
                mx = t
            }
        }
    }
    return mx
}

fun main() {

    if (largestofthree(listOf(8, 1, 9)) == 981) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (largestofthree(listOf(8, 6, 7, 1, 0)) == 8760) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
