fun specialnumbers(a: List<Int>): Int {
    var t = 0
    a.forEachIndexed {i, n ->
                          if (a.size % (i + 1) == 0) {
                              t += n * n
                          }
    }
    return t
}

fun main() {

    if (specialnumbers(listOf(1, 2, 3, 4)) == 21) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialnumbers(listOf(2, 7, 1, 19, 18, 3)) == 63) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
