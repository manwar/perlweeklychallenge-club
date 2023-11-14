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

fun reversepairs(a: List<Int>): Int {
    return combinations(a, 2).filter {v -> v[1] > 2 * v[0]}.size
}

fun main() {

    if (reversepairs(listOf(1, 3, 2, 3, 1)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversepairs(listOf(2, 4, 3, 5, 1)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
