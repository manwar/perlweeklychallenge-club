fun maxdistance(a: List<Int>, b: List<Int>): Int {
    val l1 = a.minOrNull()!!
    val h1 = a.maxOrNull()!!
    val l2 = b.minOrNull()!!
    val h2 = b.maxOrNull()!!
    return listOf(h1 - l2, h2 - l1).maxOrNull()!!
}

fun main() {

    if (maxdistance(listOf(4, 5, 7), listOf(9, 1, 3, 4)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdistance(listOf(2, 3, 5, 4), listOf(3, 2, 5, 5, 8, 7)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdistance(listOf(2, 1, 11, 3), listOf(2, 5, 10, 2)) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdistance(listOf(1, 2, 3), listOf(3, 2, 1)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdistance(listOf(1, 0, 2, 3), listOf(5, 0)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
