fun shortestdistance(a0: List<Int>): List<List<Int>> {
    if (a0.size % 2 != 0) {
        return emptyList<List<Int>>()
    }
    var a = ArrayList(a0)
        a.sort()
    var out = ArrayList<List<Int>>()
    for (t in a.chunked(2)) {
        if (t[0] != t[1]) {
            return emptyList<List<Int>>()
        }
        out.add(listOf(t[0], t[0]))
    }
    return out.toList()
}

fun main() {

    if (shortestdistance(listOf(3, 2, 3, 2, 2, 2)) == listOf(listOf(2, 2), listOf(2, 2), listOf(3, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shortestdistance(listOf(1, 2, 3, 4)) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
