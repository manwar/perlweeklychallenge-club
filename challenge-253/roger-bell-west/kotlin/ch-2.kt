fun weakestrows(a: List<List<Int>>): List<Int> {
    var p = ArrayList(generateSequence(0) { it + 1 }.take(a.size).toList())
    val b = a.map{it.sum()}
    p.sortBy {b[it]}
    return p.toList()
}

fun main() {

    if (weakestrows(listOf(listOf(1, 1, 0, 0, 0), listOf(1, 1, 1, 1, 0), listOf(1, 0, 0, 0, 0), listOf(1, 1, 0, 0, 0), listOf(1, 1, 1, 1, 1))) == listOf(2, 0, 3, 1, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (weakestrows(listOf(listOf(1, 0, 0, 0), listOf(1, 1, 1, 1), listOf(1, 0, 0, 0), listOf(1, 0, 0, 0))) == listOf(0, 2, 3, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
