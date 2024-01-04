fun smallestindex(a: List<Int>): Int {
    a.forEachIndexed {i, n ->
                          if (n % 10 == i) {
                              return i
                          }
    }
    return -1
}

fun main() {

    if (smallestindex(listOf(0, 1, 2)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallestindex(listOf(4, 3, 2, 1)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (smallestindex(listOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 0)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
