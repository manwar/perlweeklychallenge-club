fun buildarray(a: List<Int>): List<Int> {
    return a.map{a[it]}.toList()
}

fun main() {

    if (buildarray(listOf(0, 2, 1, 5, 3, 4)) == listOf(0, 1, 2, 4, 5, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (buildarray(listOf(5, 0, 1, 2, 3, 4)) == listOf(4, 5, 0, 1, 2, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
