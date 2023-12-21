fun shortestdistance(a: String, c: Char): List<Int> {
    var q = ArrayDeque<Pair<Int, Int>>()
    var j = 0
    while (j >= 0) {
        val p = a.indexOf(c, j)
        if (p >= 0) {
            q.add(Pair(p, 0))
            j = p + 1
        } else {
            j = -1
        }
    }
    val invalid = a.length + 1
    var out = ArrayList(generateSequence(invalid) { invalid }.take(a.length).toList())
    while (q.size > 0) {
        val pp = q.removeFirst()
        val i = pp.first
        val v = pp.second
        if (out[i] == invalid) {
            out[i] = v
            if (i > 0) {
                q.add(Pair(i - 1, v + 1))
            }
            if (i < a.length - 1) {
                q.add(Pair(i + 1, v + 1))
            }
        }
    }
    return out.toList()
}

    fun main() {

    if (shortestdistance("loveleetcode", 'e') == listOf(3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shortestdistance("aaab", 'b') == listOf(3, 2, 1, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
