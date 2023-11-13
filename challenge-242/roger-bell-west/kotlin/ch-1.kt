fun halfmissing(a: List<Int>, bh: Set<Int>): List<Int> {
    return a.filter {n -> !bh.contains(n)}.distinct().toList()
}

fun missingmembers(a: List<Int>, b: List<Int>): List<List<Int>> {
    val ah = a.toSet()
    val bh = b.toSet()
    return listOf(halfmissing(a, bh), halfmissing(b, ah))
}

fun main() {

    if (missingmembers(listOf(1, 2, 3), listOf(2, 4, 6)) == listOf(listOf(1, 3), listOf(4, 6))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (missingmembers(listOf(1, 2, 3, 3), listOf(1, 1, 2, 2)) == listOf(listOf(3), emptyList<Int>())) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
