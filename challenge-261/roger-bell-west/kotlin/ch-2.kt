
fun multiplybytwo(a: List<Int>, start: Int): Int {
    val p = a.toSet()
    var v = start
    while (p.contains(v)) {
        v *= 2
    }
    return v
}

fun main() {

    if (multiplybytwo(listOf(5, 3, 6, 1, 12), 3) == 24) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (multiplybytwo(listOf(1, 2, 4, 3), 1) == 8) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (multiplybytwo(listOf(5, 6, 7), 2) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
