fun targetarray(a: List<Int>, indices: List<Int>): List<Int> {
    var c = ArrayList<Int>()
    indices.forEachIndexed{i, ix ->
        if (ix == c.size) {
            c.add(a[i])
        } else {
            c.add(ix, a[i])
        }
    }
    return c.toList()
}

fun main() {

    if (targetarray(listOf(0, 1, 2, 3, 4), listOf(0, 1, 2, 2, 1)) == listOf(0, 4, 1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (targetarray(listOf(1, 2, 3, 4, 0), listOf(0, 1, 2, 3, 0)) == listOf(0, 1, 2, 3, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (targetarray(listOf(1), listOf(0)) == listOf(1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
