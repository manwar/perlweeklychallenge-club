fun smallerthancurrent(a: List<Int>): List<Int> {
    var s = ArrayList(a)
    s.sort()
    var l = mutableMapOf<Int, Int>()
    s.forEachIndexed {i, n ->
                          if (!l.contains(n)) {
                              l.put(n, i)
                          }
    }
    return a.map { l.getValue(it) }.toList()
}

fun main() {

    if (smallerthancurrent(listOf(5, 2, 1, 6)) == listOf(2, 1, 0, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallerthancurrent(listOf(1, 2, 0, 3)) == listOf(1, 2, 0, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallerthancurrent(listOf(0, 1)) == listOf(0, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallerthancurrent(listOf(9, 4, 9, 2)) == listOf(2, 1, 2, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
