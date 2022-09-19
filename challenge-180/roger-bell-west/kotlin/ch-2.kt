fun trimlist(n: List<Int>, i: Int): List<Int> {
    return n.filter{it > i}
}

fun main() {
    if (trimlist(listOf(1, 4, 2, 3, 5), 3) == listOf(4, 5)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (trimlist(listOf(9, 0, 6, 2, 3, 8, 5), 4) == listOf(9, 6, 8, 5)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
