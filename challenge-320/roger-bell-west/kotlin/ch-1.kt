fun maximumcount(a: List<Int>): Int {
    var pos = 0
    var neg = 0
    for (n in a) {
        if (n > 0) {
            pos++
        } else if (n < 0) {
            neg++
        }
    }
    return listOf(pos, neg).maxOrNull()!!
}

fun main() {

    if (maximumcount(listOf(-3, -2, -1, 1, 2, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumcount(listOf(-2, -1, 0, 0, 1)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumcount(listOf(1, 2, 3, 4)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
