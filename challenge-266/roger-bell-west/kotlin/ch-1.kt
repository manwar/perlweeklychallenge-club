fun getlistset(a: String): Pair<List<String>, Set<String>> {
    var la = a.split(" ").toList()
    var ca = mutableMapOf<String, Int>().withDefault({0})
    for (w in la) {
        ca.set(w, ca.getValue(w) + 1)
    }
    la = la.filter{ca.getValue(it) == 1}.toList()
    val cb = ca.keys.toSet();
    return Pair(la, cb)
}

fun uncommonwords(a: String, b: String): List<String> {
    val xa = getlistset(a)
    val la = xa.first
    val sa = xa.second
    val xb = getlistset(b)
    val lb = xb.first
    val sb = xb.second
    var out = ArrayList<String>()
    for (x in listOf(Pair(la, sb), Pair(lb, sa))) {
        for (w in x.first) {
            if (!x.second.contains(w)) {
                out.add(w)
            }
        }
    }
    return out.toList()
}

fun main() {

    if (uncommonwords("Mango is sweet", "Mango is sour") == listOf("sweet", "sour")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uncommonwords("Mango Mango", "Orange") == listOf("Orange")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uncommonwords("Mango is Mango", "Orange is Orange") == emptyList<String>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
