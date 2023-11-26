fun arithmetictriplets(ints: List<Int>, diff: Int): Int {
    val vs = ints.toSet()
    return ints.filter { n -> vs.contains(n + diff) && vs.contains(n + diff * 2)}.size
}

fun main() {

    if (arithmetictriplets(listOf(0, 1, 4, 6, 7, 10), 3) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arithmetictriplets(listOf(4, 5, 6, 7, 8, 9), 2) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
