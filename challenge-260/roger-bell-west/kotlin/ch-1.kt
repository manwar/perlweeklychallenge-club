fun uniqueoccurrences(a: List<Int>): Int {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (n in a) {
        c.set(n, c.getValue(n) + 1)
    }
    if (c.size == c.values.toSet().size) {
        return 1
    } else {
        return 0
    }
}

fun main() {

    if (uniqueoccurrences(listOf(1, 2, 2, 1, 1, 3)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniqueoccurrences(listOf(1, 2, 3)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniqueoccurrences(listOf(-2, 0, 1, -2, 1, 1, 0, 1, -2, 9)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
