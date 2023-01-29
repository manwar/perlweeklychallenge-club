fun missingnumber(l: List<Int>): Int {
    val v = l.toSet()
    for (i in 0..l.size) {
        if (!v.contains(i)) {
            return i
        }
    }
    return 0
}

fun main() {

    if (missingnumber(listOf(0, 1, 3)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (missingnumber(listOf(0, 1)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
