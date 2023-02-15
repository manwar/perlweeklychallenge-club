fun reshapematrix(m: List<List<Int>>, r: Int, c: Int): List<List<Int>> {
    val mv = m.flatten()
    if (r * c != mv.size) {
        return listOf(listOf(0))
    }
    var out = ArrayList<List<Int>>()
    for (i in 0 .. r - 1) {
        out.add(mv.slice(i * c .. (i + 1) * c - 1).toList())
    }
    return out.toList()
}


fun main() {

    if (reshapematrix(listOf(listOf(1, 2), listOf(3, 4)), 1, 4) == listOf(listOf(1, 2, 3, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reshapematrix(listOf(listOf(1, 2, 3), listOf(4, 5, 6)), 3, 2) == listOf(listOf(1, 2), listOf(3, 4), listOf(5, 6))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reshapematrix(listOf(listOf(1, 2)), 3, 2) == listOf(listOf(0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
