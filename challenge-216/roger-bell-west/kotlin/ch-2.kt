fun word2map(word: String): Map<Char, Int> {
    var m = mutableMapOf<Char, Int>()
    for (c in word.lowercase()) {
        if (m.contains(c)) {
            m.set(c, m.get(c)!! + 1)
        } else {
            m.set(c, 1)
        }
    }
    return m
}

fun shallowclonemap(m: Map<Char, Int>): MutableMap<Char, Int> {
    var mm = mutableMapOf<Char, Int>()
    for (k in m.keys) {
        mm.set(k, m.get(k)!!)
    }
    return mm
}

fun wordstickers(stickers: List<String>, word: String): Int {
    var w = word2map(word)
    var t = shallowclonemap(w)
    var stick = ArrayList<Map<Char, Int>>()
    for (s in stickers) {
        val f = word2map(s)
        for (c in f.keys) {
            t.remove(c)
        }
        stick.add(f)
    }
    if (t.size > 0) {
        return 0
    }
    var stack = arrayListOf(Pair(w, 0))
    while (stack.size > 0) {
        val st = stack.removeFirst()
        if (st.first.size == 0) {
            return st.second
        } else {
            val n = st.second + 1;
            for (sti in stick) {
                var sp = shallowclonemap(st.first)
                var v = false
                for (l in sti.keys) {
                    if (sp.contains(l)) {
                        v = true
                        val p = sp.get(l)!! - sti.get(l)!!
                        if (p > 0) {
                            sp.put(l, p)
                        } else {
                            sp.remove(l)
                        }
                    }
                }
                if (v) {
                    stack.add(Pair(sp, n))
                }
            }
        }
    }
    return 0
}

fun main() {

    if (wordstickers(listOf("perl", "raku", "python"), "peon") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordstickers(listOf("love", "hate", "angry"), "goat") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordstickers(listOf("come", "nation", "delta"), "accomodation") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordstickers(listOf("come", "country", "delta"), "accomodation") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
