fun counterify(a: List<Int>): Map<Int, Int> {
    var cc = mutableMapOf<Int, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun equalgroup(a: List<Int>): Boolean {
    val s = counterify(a)
    val v = s.values.toSet().toList().sorted()
    val l = v[0]
    if (l < 2) {
        return false
    }
    for (t in 2 .. l) {
        if (v.all{c -> c % t == 0}) {
            return true
            }
    }
    return false
}

fun main() {

    if (equalgroup(listOf(1, 1, 2, 2, 2, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!equalgroup(listOf(1, 1, 1, 2, 2, 2, 3, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (equalgroup(listOf(5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!equalgroup(listOf(1, 2, 3, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (equalgroup(listOf(8, 8, 9, 9, 10, 10, 11, 11))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
