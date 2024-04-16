fun str2hash(a: String): Map<Char, Int> {
    var m = mutableMapOf<Char, Int>().withDefault({0})
    for (c in a) {
        if (c.isLetter()) {
            val lc = c.lowercaseChar()
            m.set(lc, m.getValue(lc) + 1)
        }
    }
    return m
}

fun completingword(a: String, cw: List<String>): String {
    val ah = str2hash(a)
    var out = ArrayList<String>()
    for (t in cw) {
        var valid = true
        val th = str2hash(t)
        for ((k, v) in ah) {
            if (valid) {
                if (!th.contains(k)) {
                    valid = false
                    break
                } else {
                    if (th.getValue(k) < v) {
                        valid = false
                        break
                    }
                }
            }
        }
        if (valid) {
            out.add(t)
        }
    }
    if (out.size == 0) {
        return ""
    }
    out.sortWith(compareBy { it.length })
    return out[0]
}

fun main() {

    if (completingword("aBc 11c", listOf("accbbb", "abc", "abbc")) == "accbbb") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (completingword("La1 abc", listOf("abcl", "baacl", "abaalc")) == "baacl") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (completingword("JB 007", listOf("jj", "bb", "bjb")) == "bjb") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
