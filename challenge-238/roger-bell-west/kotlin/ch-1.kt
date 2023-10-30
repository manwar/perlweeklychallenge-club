fun runningsum(a: List<Int>): List<Int> {
    var b = ArrayList(a)
    for ((i, _) in b.withIndex()) {
        if (i > 0) {
            b[i] += b[i - 1]
        }
    }
    return b.toList()
}

fun main() {

    if (runningsum(listOf(1, 2, 3, 4, 5)) == listOf(1, 3, 6, 10, 15)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (runningsum(listOf(1, 1, 1, 1, 1)) == listOf(1, 2, 3, 4, 5)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (runningsum(listOf(0, -1, 1, 2)) == listOf(0, -1, 0, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
