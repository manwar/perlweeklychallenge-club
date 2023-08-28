fun notminmax(a: List<Int>): List<Int> {
    val mn = a.minOrNull()!!
    val mx = a.maxOrNull()!!
    return a.filter {it != mn && it != mx}.toList()
}

fun main() {

    if (notminmax(listOf(3, 2, 1, 4)) == listOf(3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (notminmax(listOf(3, 1)) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (notminmax(listOf(2, 1, 3)) == listOf(2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
