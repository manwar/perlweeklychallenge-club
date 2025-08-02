fun xmatrix(a: List<List<Int>>): Boolean {
    val order = a.size - 1
    var valid = true
    a.forEachIndexed{y, row ->
                         row.forEachIndexed{x, value ->
                                                if (x == y || x == order - y) {
                                                    if (value == 0) {
                                                        valid = false;
                                                    }
                                                } else {
                                                    if (value != 0) {
                                                        valid = false;
                                                    }
                                                }
                         }
    }
    return valid
}

fun main() {

    if (xmatrix(listOf(listOf(1, 0, 0, 2), listOf(0, 3, 4, 0), listOf(0, 5, 6, 0), listOf(7, 0, 0, 1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!xmatrix(listOf(listOf(1, 2, 3), listOf(4, 5, 6), listOf(7, 8, 9)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (xmatrix(listOf(listOf(1, 0, 2), listOf(0, 3, 0), listOf(4, 0, 5)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
