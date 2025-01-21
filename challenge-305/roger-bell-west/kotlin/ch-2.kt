fun aliendictionary(a: List<String>, dc: List<Char>): List<String> {
    val mxl = a.map{it.length}.maxOrNull()!!
    var dh = mutableMapOf<Char, Int>()
    dc.forEachIndexed{i, c ->
                          dh.set(c, i + 1)
    }
    var numerics = mutableMapOf<String, Long>()
    for (w in a) {
        var n = 0.toLong()
        val cc = w.toList()
        for (i in 0 .. mxl - 1) {
            n *= 27.toLong()
            if (i < w.length) {
                n += dh.getValue(cc[i]).toLong()
            }
        }
        numerics.set(w, n)
    }
    val customComparator = Comparator {
        i: String, j: String ->
            val d = numerics.getValue(i) - numerics.getValue(j)
        if (d > 0L) {
            1
        } else if (d < 0L) {
            -1
        } else {
            0
        }
    }
    return a.sortedWith(customComparator)
}

fun main() {

    if (aliendictionary(listOf("perl", "python", "raku"), listOf('h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z')) == listOf("raku", "python", "perl")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(' ')
    if (aliendictionary(listOf("the", "weekly", "challenge"), listOf('c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z')) == listOf("challenge", "the", "weekly")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
