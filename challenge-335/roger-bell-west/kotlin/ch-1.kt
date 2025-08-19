fun counterify(a: List<Char>): Map<Char, Int> {
    var cc = mutableMapOf<Char, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun commoncharacters(a: List<String>): List<String> {
    var mc = mutableMapOf<Char, Int>().withDefault({0})
    var first = true
    for (s in a) {
        val mk = counterify(s.toCharArray().toList())
        if (first) {
            mc = mk.toMutableMap()
            first = false
        } else {
            for (k in mc.keys.toList()) {
                if (mk.contains(k)) {
                    mc.set(k, listOf(mc.getValue(k), mk.getValue(k)).minOrNull()!!)
                } else {
                    mc.remove(k)
                }
            }
        }
    }
    var out = ArrayList<String>()
    for (c in mc.keys.sorted()) {
        val s = c.toString()
        for (n in 1 .. mc.getValue(c)) {
            out.add(s)
        }
    }
    return out.toList()
}

fun main() {

    if (commoncharacters(listOf("bella", "label", "roller")) == listOf("e", "l", "l")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (commoncharacters(listOf("cool", "lock", "cook")) == listOf("c", "o")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (commoncharacters(listOf("hello", "world", "pole")) == listOf("l", "o")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (commoncharacters(listOf("abc", "def", "ghi")) == emptyList<String>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (commoncharacters(listOf("aab", "aac", "aaa")) == listOf("a", "a")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
