fun reflect(a: Int): Int {
    var p = ArrayList<Int>()
    var am = a
    while (true) {
        p.add(am % 2)
        am = am shr 1
        if (am == 0) {
            break
        }
    }
    var ar = 0
    var s = p.size
    for (n in p) {
        s = s - 1
        ar += n shl s
    }
    return ar
}

fun binaryreflection(ax: List<Int>): List<Int> {
    val k = ax.map{ x -> reflect(x) }
    var i = ArrayList((0 .. ax.size - 1).toList())
    val customComparator = Comparator {
        a: Int, b: Int ->
            if (k[a] == k[b]) {
                ax[a] - ax[b]
            } else {
                k[a] - k[b]
            }
    }
    return i.sortedWith(customComparator).map {x -> ax[x]}.toList()
}

fun main() {

    if (binaryreflection(listOf(3, 6, 12)) == listOf(3, 6, 12)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryreflection(listOf(1, 2, 4, 8)) == listOf(1, 2, 4, 8)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryreflection(listOf(7, 8, 9, 10)) == listOf(8, 10, 7, 9)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryreflection(listOf(5, 9, 15, 17)) == listOf(5, 9, 15, 17)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryreflection(listOf(11, 13, 14, 19)) == listOf(14, 13, 11, 19)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
