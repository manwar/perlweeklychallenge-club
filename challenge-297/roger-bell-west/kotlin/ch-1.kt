fun contiguousarray(a: List<Int>): Int {
    val ml = (1 + a.size) / 2 * 2;
    for (l in ml downTo(2) step (2)) {
        for (start in 0 .. a.size - l) {
            val end = start + l - 1
            if (a.slice(start .. end).sum() * 2 == l) {
                return l
            }
        }
    }
    return 0
}

fun main() {

    if (contiguousarray(listOf(1, 0)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (contiguousarray(listOf(0, 1, 0)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (contiguousarray(listOf(0, 0, 0, 0, 0)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (contiguousarray(listOf(0, 1, 0, 0, 1, 0)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
