import kotlin.math.min

fun commoncharacters(a: List<String>): List<Char> {
    var ac = ArrayList<Map<Char, Int>>()
    for (w in a) {
        var h = mutableMapOf<Char, Int>().withDefault({0})
        for (c in w.toCharArray()) {
            h.set(c, h.getValue(c) + 1)
        }
        ac.add(h)
    }
    var vc = mutableMapOf<Char, Int>()
    for (i in 0 .. ac.size - 1) {
        if (i == 0) {
            for (c in ac[i].keys) {
                vc.set(c, ac[i].get(c)!!)
            }
        } else {
            for (c in vc.keys.toList()) {
                if (ac[i].contains(c)) {
                    vc.set(c, min(vc.get(c)!!, ac[i].get(c)!!))
                } else {
                    vc.remove(c)
                }
            }
        }
    }
    var out = ArrayList<Char>()
    for (c in a[0].toCharArray()) {
        if (vc.contains(c)) {
            out.add(c)
            vc.set(c, vc.get(c)!! - 1)
            if (vc.get(c)!! == 0) {
                vc.remove(c)
            }
        }
    }
    return out.toList()
}

fun main() {

    if (commoncharacters(listOf("java", "javascript", "julia")) == listOf('j', 'a')) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (commoncharacters(listOf("bella", "label", "roller")) == listOf('e', 'l', 'l')) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (commoncharacters(listOf("cool", "lock", "cook")) == listOf('c', 'o')) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
