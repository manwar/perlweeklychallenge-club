fun persistence(a: Int): Int {
    var steps = 0
    var b = a
    while (b > 9) {
        steps += 1
        var p = 1
        while (b > 0) {
            p *= b % 10
            b /= 10
        }
        b = p
    }
    return steps
}

fun persistencearray(a: List<Int>): List<Int> {
    var b = ArrayList(a)
    var c = mutableMapOf<Int, Int>()
    for (v in a.toSet()) {
        c[v] = persistence(v);
    }
    b.sort()
    b.sortBy { c[it] }
    return b.toList()
}

fun main() {

    if (persistencearray(listOf(15, 99, 1, 34)) == listOf(1, 15, 34, 99)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (persistencearray(listOf(50, 25, 33, 22)) == listOf(22, 33, 50, 25)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
