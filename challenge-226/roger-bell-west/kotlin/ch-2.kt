fun zeroarray(a: List<Int>): Int {
    var s = a.toMutableSet()
    s.remove(0)
    return s.size
}

fun main() {

    if (zeroarray(listOf(1, 5, 0, 3, 5)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zeroarray(listOf(0)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zeroarray(listOf(2, 1, 4, 0, 3)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
