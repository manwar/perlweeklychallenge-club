fun maximumfrequency(a: List<Int>): Int {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (w in a) {
        c.set(w, c.getValue(w) + 1)
    }
    val mx = c.values.maxOrNull()!!
    return mx * c.values.filter{it == mx}.size
}

fun main() {

    if (maximumfrequency(listOf(1, 2, 2, 4, 1, 5)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumfrequency(listOf(1, 2, 3, 4, 5)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
