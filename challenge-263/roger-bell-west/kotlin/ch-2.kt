fun mergeitems(a: List<List<Int>>, b: List<List<Int>>): List<List<Int>> {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (v in listOf(a, b)) {
        for (w in v) {
            c.set(w[0], c.getValue(w[0]) + w[1])
        }
    }
    var k = c.keys.toList().sorted()
    return k.map { listOf(it, c.getValue(it)) }.toList()
}

fun main() {

    if (mergeitems(listOf(listOf(1, 1), listOf(2, 1), listOf(3, 2)), listOf(listOf(2, 2), listOf(1, 3))) == listOf(listOf(1, 4), listOf(2, 3), listOf(3, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mergeitems(listOf(listOf(1, 2), listOf(2, 3), listOf(1, 3), listOf(3, 2)), listOf(listOf(3, 1), listOf(1, 3))) == listOf(listOf(1, 8), listOf(2, 3), listOf(3, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mergeitems(listOf(listOf(1, 1), listOf(2, 2), listOf(3, 3)), listOf(listOf(2, 3), listOf(2, 4))) == listOf(listOf(1, 1), listOf(2, 9), listOf(3, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
