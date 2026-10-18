fun wordsquares(a: List<String>): List<String> {
    val l = a[0].length
    val words = a.toSet()
    var queue = ArrayDeque<List<String>>()
    for (w in a) {
        queue.add(listOf(w))
    }
    while (queue.size > 0) {
        val p = queue.removeAt(0)
        if (p.size == l) {
            return p
        } else {
            for (ca in words.subtract(p.toSet())) {
                var valid = true
                var lp = true
                ca.toList().forEachIndexed {i, c ->
                    if (lp) {
                        if (i >= p.size) {
                            lp = false
                        }
                        if (lp && c != p[i][p.size]) {
                            valid = false
                            lp = false
                        }
                    }
                }
                if (valid) {
                    var pw = ArrayList(p)
                    pw.add(ca)
                    queue.add(pw.toList())
                }
            }
        }
    }
    return emptyList()
}

fun main() {

    if (wordsquares(listOf("MA", "AM", "MY", "ME")) == listOf("MA", "AM")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsquares(listOf("SUN", "USE", "NET", "SEE", "TEN")) == listOf("SUN", "USE", "NET")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsquares(listOf("BOAT", "TEAL", "AREA", "TSAR", "OGRE")) == listOf("BOAT", "OGRE", "AREA", "TEAL")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsquares(listOf("CARD", "AREA", "REAR", "DART")) == listOf("CARD", "AREA", "REAR", "DART")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsquares(listOf("HEART", "TREND", "EMBER", "RESIN", "ABUSE")) == listOf("HEART", "EMBER", "ABUSE", "RESIN", "TREND")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
