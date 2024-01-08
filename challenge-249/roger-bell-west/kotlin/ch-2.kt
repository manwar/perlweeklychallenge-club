fun distringmatch(a: String): List<Int> {
    var v = 1 shl (a.length - 1)
    var wv = v shl 1
    var out = ArrayList<Int>()
    var q = ArrayList<Int>()
    out.add(wv)
    q.add(wv)
    for (c in a) {
        if (c == 'I') {
            wv += v
        } else {
            wv -= v
        }
        v = v shr 1
        out.add(wv)
        q.add(wv)
    }
    q.sort()
    var c = mutableMapOf<Int, Int>()
    q.forEachIndexed {i, n -> c.put(n, i)}
    return out.map{c.getValue(it)}.toList()
}

fun main() {

    if (distringmatch("IDID") == listOf(0, 4, 1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (distringmatch("III") == listOf(0, 1, 2, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (distringmatch("DDI") == listOf(3, 2, 0, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
