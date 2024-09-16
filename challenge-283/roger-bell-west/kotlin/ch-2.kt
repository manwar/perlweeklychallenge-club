fun digitcountvalue(a: List<Int>): Boolean {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (p in a) {
        c.set(p, c.getValue(p) + 1)
    }
    for (ix in 0 .. a.size - 1) {
        if (a[ix] != c.getValue(ix)) {
            return false
        }
    }
    return true
}

fun main() {

    if (digitcountvalue(listOf(1, 2, 1, 0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!digitcountvalue(listOf(0, 3, 0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
