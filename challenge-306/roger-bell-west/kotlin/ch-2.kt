fun lastelement(a: List<Int>): Int {
    var b = ArrayList(a)
    while (true) {
        b.sort()
        var f = b.removeLast()
        var s = b.removeLast()
        if (f > s) {
            b.add(f - s)
        }
        if (b.size == 0) {
            return 0
        }
        if (b.size == 1) {
            return b[0]
        }
    }
}

fun main() {

    if (lastelement(listOf(3, 8, 5, 2, 9, 2)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (lastelement(listOf(3, 2, 5)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
