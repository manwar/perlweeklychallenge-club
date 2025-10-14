fun zerofriend(a: List<Int>): Int {
    val b = a.map {Math.abs(it)}.minOrNull()!!
    if (a.contains(b)) {
        return b
    }
    return -b
}

fun main() {

    if (zerofriend(listOf(4, 2, -1, 3, -2)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zerofriend(listOf(-5, 5, -3, 3, -1, 1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zerofriend(listOf(7, -3, 0, 2, -8)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zerofriend(listOf(-2, -5, -1, -8)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zerofriend(listOf(-2, 2, -4, 4, -1, 1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
