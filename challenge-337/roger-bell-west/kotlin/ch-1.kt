fun smallerthancurrent(a: List<Int>): List<Int> {
    val b = a.sorted()
    var m = mutableMapOf<Int, Int>()
    for ((i, v) in b.withIndex()) {
        if (!m.contains(v)) {
            m.put(v, i)
        }
    }
    return a.map{ m.getValue(it) }.toList()
}

fun main() {

    if (smallerthancurrent(listOf(6, 5, 4, 8)) == listOf(2, 1, 0, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallerthancurrent(listOf(7, 7, 7, 7)) == listOf(0, 0, 0, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallerthancurrent(listOf(5, 4, 3, 2, 1)) == listOf(4, 3, 2, 1, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallerthancurrent(listOf(-1, 0, 3, -2, 1)) == listOf(1, 2, 4, 0, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallerthancurrent(listOf(0, 1, 1, 2, 0)) == listOf(0, 2, 2, 4, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
