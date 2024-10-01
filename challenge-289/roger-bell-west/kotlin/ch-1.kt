fun thirdmaximum(a: List<Int>): Int {
    val p = a.distinct().sorted().reversed()
    if (p.size > 2) {
        return p[2]
    } else {
        return p[0]
    }
}

fun main() {

    if (thirdmaximum(listOf(5, 6, 4, 1)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thirdmaximum(listOf(4, 5)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thirdmaximum(listOf(1, 2, 2, 3)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
