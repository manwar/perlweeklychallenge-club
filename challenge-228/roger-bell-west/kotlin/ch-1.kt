fun uniquesum(a: List<Int>): Int {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (n in a) {
        c.set(n, c.getValue(n) + 1)
    }
    return c.filter {(_, v) -> v == 1}.map {(k, _) -> k}.sum()
}

fun main() {

    if (uniquesum(listOf(2, 1, 3, 2)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquesum(listOf(1, 1, 1, 1)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquesum(listOf(2, 1, 3, 4)) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
