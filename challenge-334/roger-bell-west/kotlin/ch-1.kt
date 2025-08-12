fun rangesum(a: List<Int>, s: Int, e: Int): Int {
    return a.slice(s .. e).sum()
}

fun main() {

    if (rangesum(listOf(-2, 0, 3, -5, 2, -1), 0, 2) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rangesum(listOf(1, -2, 3, -4, 5), 1, 3) == -3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rangesum(listOf(1, 0, 2, -1, 3), 3, 4) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rangesum(listOf(-5, 4, -3, 2, -1, 0), 0, 3) == -2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rangesum(listOf(-1, 0, 2, -3, -2, 1), 0, 2) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
