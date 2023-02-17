fun monotonicarray(l: List<Int>): Boolean {
    var d = ArrayList<Int>()
    for (i in l.windowed(size = 2)) {
        d.add(i[1] - i[0])
    }
    return d.minOrNull()!! * d.maxOrNull()!! >= 0
}

fun main() {

    if (monotonicarray(listOf(1, 2, 2, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!monotonicarray(listOf(1, 3, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (monotonicarray(listOf(6, 5, 5, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
