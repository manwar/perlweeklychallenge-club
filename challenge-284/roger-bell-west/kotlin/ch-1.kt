fun luckyinteger(a: List<Int>): Int {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (p in a) {
        c.set(p, c.getValue(p) + 1)
    }
    var c1 = c.values.sorted().reversed()
    var c2 = c.keys.sorted().reversed()
    for (v1 in c1) {
        for (v2 in c2) {
            if (c[v2] == v1 && v1 == v2) {
                return v2
            }
        }
    }
    return -1
}

fun main() {

    if (luckyinteger(listOf(2, 2, 3, 4)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (luckyinteger(listOf(1, 2, 2, 3, 3, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (luckyinteger(listOf(1, 1, 1, 3)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
