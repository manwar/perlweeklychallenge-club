import kotlin.math.*

fun maximumones(a: List<List<Int>>): Int {
    val ax = a.map{it.sum()}.toList()
    val am = ax.maxOrNull()!!
    return ax.indexOf(am) + 1
}

fun main() {

    if (maximumones(listOf(listOf(0, 1), listOf(1, 0))) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumones(listOf(listOf(0, 0, 0), listOf(1, 0, 1))) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumones(listOf(listOf(0, 0), listOf(1, 1), listOf(0, 0))) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
