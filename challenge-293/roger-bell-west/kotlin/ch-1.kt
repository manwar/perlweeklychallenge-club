fun counterify(a: List<Int>): Map<Int, Int> {
    var cc = mutableMapOf<Int, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun dvalue(a: List<Int>): Int {
    if (a[0] < a[1]) {
        return a[0] * 64 + a[1]
    } else {
        return a[1] * 64 + a[0]
    }
}

fun similardominoes(a: List<List<Int>>): Int {
    val c = counterify(a.map{dvalue(it)})
    var t = 0
    for (v in c.values) {
        if (v > 1) {
            t += v
        }
    }
    return t
}

fun main() {

    if (similardominoes(listOf(listOf(1, 3), listOf(3, 1), listOf(2, 4), listOf(6, 8))) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (similardominoes(listOf(listOf(1, 2), listOf(2, 1), listOf(1, 1), listOf(1, 2), listOf(2, 2))) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
