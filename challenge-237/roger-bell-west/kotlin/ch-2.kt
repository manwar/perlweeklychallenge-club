fun maximisegreatness(a: List<Int>): Int {
    val b = a.sorted()
    var g = 0
    for (c in b) {
        if (c > b[g]) {
            g += 1
        }
    }
    return g
}

fun main() {

    if (maximisegreatness(listOf(1, 3, 5, 2, 1, 3, 1)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximisegreatness(listOf(1, 2, 3, 4)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
