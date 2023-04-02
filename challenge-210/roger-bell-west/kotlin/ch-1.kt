fun killandwin(a: List<Int>): Int {
    return a.sum()
}

fun main() {

    if (killandwin(listOf(2, 3, 1)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (killandwin(listOf(1, 1, 2, 2, 2, 3)) == 11) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
