fun mingap(a: List<Int>): Int {
    var mg = a[a.size - 1] - a[0]
    var mv = 0
    for (p in a.windowed(size = 2)) {
        val delta = p[1] - p[0]
        if (delta < mg) {
            mg = delta
            mv = p[1]
        }
    }
    return mv
}

fun main() {

    if (mingap(listOf(2, 8, 10, 11, 15)) == 11) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mingap(listOf(1, 5, 6, 7, 14)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mingap(listOf(8, 20, 25, 28)) == 28) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
