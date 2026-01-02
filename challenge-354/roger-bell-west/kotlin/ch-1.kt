fun minabsdiff(a: List<Int>): List<List<Int>> {
    val b = a.sorted()
    var out = ArrayList<List<Int>>()
    var mindiff = 1 + b[b.size - 1] - b[0]
    for (c in b.windowed(size = 2)) {
        val d = c[1] - c[0]
        if (d < mindiff) {
            out.clear() 
            mindiff = d
        }
        if (d == mindiff) {
            out.add(c.toList())
        }
    }
    return out.toList()
}

fun main() {

    if (minabsdiff(listOf(4, 2, 1, 3)) == listOf(listOf(1, 2), listOf(2, 3), listOf(3, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minabsdiff(listOf(10, 100, 20, 30)) == listOf(listOf(10, 20), listOf(20, 30))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minabsdiff(listOf(-5, -2, 0, 3)) == listOf(listOf(-2, 0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minabsdiff(listOf(8, 1, 15, 3)) == listOf(listOf(1, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minabsdiff(listOf(12, 5, 9, 1, 15)) == listOf(listOf(9, 12), listOf(12, 15))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
