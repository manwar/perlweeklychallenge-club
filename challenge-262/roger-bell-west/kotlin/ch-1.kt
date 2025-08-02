fun maxpositivenumber(a: List<Int>): Int {
    return listOf(
        a.filter { c -> c > 0 }.size,
        a.filter { c -> c < 0 }.size
    ).maxOrNull()!!
}

fun main() {

    if (maxpositivenumber(listOf(-3, 1, 2, -1, 3, -2, 4)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxpositivenumber(listOf(-1, -2, -3, 1)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxpositivenumber(listOf(1, 2)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
