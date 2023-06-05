fun sortedsquares(lst: List<Int>): List<Int> {
    return lst.map {it * it}.sorted()
}

fun main() {

    if (sortedsquares(listOf(-2, -1, 0, 3, 4)) == listOf(0, 1, 4, 9, 16)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortedsquares(listOf(5, -4, -1, 3, 6)) == listOf(1, 9, 16, 25, 36)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
