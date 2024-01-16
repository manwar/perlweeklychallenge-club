fun submatrixsum(a: List<List<Int>>): List<List<Int>> {
    var out = ArrayList<List<Int>>()
    for (y in 0 .. a.size - 2) {
        var row = ArrayList<Int>()
        for (x in 0 .. a[0].size - 2) {
            var s = 0
            for (ya in y .. y + 1) {
                for (xa in x .. x + 1) {
                    s += a[ya][xa]
                }
            }
            row.add(s)
        }
        out.add(row.toList())
    }
    return out.toList()
}

fun main() {

    if (submatrixsum(listOf(listOf(1, 2, 3, 4), listOf(5, 6, 7, 8), listOf(9, 10, 11, 12))) == listOf(listOf(14, 18, 22), listOf(30, 34, 38))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (submatrixsum(listOf(listOf(1, 0, 0, 0), listOf(0, 1, 0, 0), listOf(0, 0, 1, 0), listOf(0, 0, 0, 1))) == listOf(listOf(2, 1, 0), listOf(1, 2, 1), listOf(0, 1, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
