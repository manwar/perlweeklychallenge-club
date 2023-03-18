fun v2hm(a: List<String>): Map<String, Int> {
    var h = mutableMapOf<String, Int>()
    for ((i, x) in a.withIndex()) {
        if (!h.containsKey(x)) {
            h[x] = i
        }
    }
    return h
}

fun minindexsum(a: List<String>, b: List<String>): List<String> {
    val ah = v2hm(a)
    val bh = v2hm(b)
    var out = ArrayList<String>()
    var mi = a.size + b.size
    for (w in a) {
        if (bh.containsKey(w)) {
            val mv = ah[w]!! + bh[w]!!
            if (mv < mi) {
                out.clear()
                mi = mv
            }
            if (mv == mi) {
                out.add(w)
            }
        }
    }
    return out.toList()
}

fun main() {

    if (minindexsum(listOf("Perl", "Raku", "Love"), listOf("Raku", "Perl", "Hate")) == listOf("Perl", "Raku")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minindexsum(listOf("A", "B", "C"), listOf("D", "E", "F")) == emptyList<String>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (minindexsum(listOf("A", "B", "C"), listOf("C", "A", "B")) == listOf("A")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
