fun absentsmallestpositive(a: List<Int>): Int {
    val tot = a.sum()
    val ex = a.toSet()
    val mul = a.size
    var n = 1
    while (true) {
        if (n * mul > tot && !ex.contains(n)) {
            return n
        }
        n += 1
    }
}

fun main() {

    if (absentsmallestpositive(listOf(1, 2, 4, 5, 6)) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(listOf(-5, -2, -1, 3)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(listOf(1, 2, 3)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(listOf(2, 3, 7, 8)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (absentsmallestpositive(listOf(1, 1, 1, 10)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
