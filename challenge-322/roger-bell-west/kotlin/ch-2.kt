fun rankarray(a: List<Int>): List<Int> {
    val b =a.toSet().toList().sorted()
    var c = mutableMapOf<Int, Int>()
    b.forEachIndexed {i, n ->
                          c[n] = i + 1
    }
    var out = ArrayList<Int>()
    for (v in a) {
        out.add(c.getValue(v))
    }
    return out.toList()
}

fun main() {

    if (rankarray(listOf(55, 22, 44, 33)) == listOf(4, 1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rankarray(listOf(10, 10, 10)) == listOf(1, 1, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rankarray(listOf(5, 1, 1, 4, 3)) == listOf(4, 1, 1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
