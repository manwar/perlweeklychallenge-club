fun maximumaverage(a: List<Int>, n: Int): Double {
    var mx = 0
    for (s in a.windowed(n)) {
        mx = listOf(mx, s.sum()).maxOrNull()!!
    }
    return mx.toDouble() / n.toDouble()
}

fun main() {

    if (maximumaverage(listOf(1, 12, -5, -6, 50, 3), 4) == 12.75) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumaverage(listOf(5), 1) == 5.0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
