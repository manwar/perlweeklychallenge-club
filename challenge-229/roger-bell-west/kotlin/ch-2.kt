fun twoofthree(a: List<List<Int>>): List<Int> {
    var ct = mutableMapOf<Int, Int>().withDefault({0})
    for (iv in a) {
        for (c in iv.toSet()) {
            ct.set(c, ct.getValue(c) + 1)
        }
    }
    var out = ArrayList(ct.filter {(_, v) -> v >= 2}.map {(k, _) -> k})
    out.sort()
    return out.toList()
}

fun main() {

    if (twoofthree(listOf(listOf(1, 1, 2, 4), listOf(2, 4), listOf(4))) == listOf(2, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (twoofthree(listOf(listOf(4, 1), listOf(2, 4), listOf(1, 2))) == listOf(1, 2, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
