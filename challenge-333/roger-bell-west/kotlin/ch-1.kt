fun straightline(a: List<List<Double>>): Boolean {
    val b = a.distinct()
    if (b.size < 3) {
        return true
    }
    val p = b[0][0]
    val q = b[1][0] - b[0][0]
    val r = b[0][1]
    val s = b[1][1] - b[0][1]
    for (tpair in b.drop(2)) {
        if (q == 0.0 && tpair[0] != b[0][0]) {
            return false
        }
        if (s == 0.0 && tpair[1] != b[0][1]) {
            return false
        }
        if (q != 0.0 && s != 0.0) {
            val n1 = (tpair[0] - p ) / q
            val n2 = (tpair[1] - r ) / s
            if (n1 != n2) {
                return false
            }
        }
    }
    return true
}

fun main() {

    if (straightline(listOf(listOf(2.0, 1.0), listOf(2.0, 3.0), listOf(2.0, 5.0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (straightline(listOf(listOf(1.0, 4.0), listOf(3.0, 4.0), listOf(10.0, 4.0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!straightline(listOf(listOf(0.0, 0.0), listOf(1.0, 1.0), listOf(2.0, 3.0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (straightline(listOf(listOf(1.0, 1.0), listOf(1.0, 1.0), listOf(1.0, 1.0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
