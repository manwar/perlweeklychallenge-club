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

fun completeday(a: List<Int>): Int {
    var ct = 0
    for (c in combinations(a, 2)) {
        if ((c[0] + c[1]) % 24 == 0) {
            ct += 1
        }
    }
    return ct
}

fun main() {

    if (completeday(listOf(12, 12, 30, 24, 24)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (completeday(listOf(72, 48, 24, 5)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (completeday(listOf(12, 18, 24)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
