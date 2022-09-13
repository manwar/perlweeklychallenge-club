fun commonpath(p: List<String>): String {
    var pa = ArrayList<List<String>>()
    var pl = ArrayList<Int>()
    for (sp in p) {
        val q = sp.split("/").toList()
        pa.add(q)
        pl.add(q.size)
    }
    var out = ArrayList<String>()
    for (cl in 0..pl.minOrNull()!!-1) {
        var ex = false
        val tx = pa[0][cl]
        for (pe in pa) {
            if (pe[cl] != tx) {
                ex = true
                break
            }
        }
        if (ex) {
            break
        }
        out.add(tx)
    }
    return out.joinToString("/")
}

fun main() {
    if (commonpath(listOf(
                       "/a/b/c/1/x.pl",
                       "/a/b/c/d/e/2/x.pl",
                       "/a/b/c/d/3/x.pl",
                       "/a/b/c/4/x.pl",
                       "/a/b/c/d/5/x.pl"
        )) == "/a/b/c") {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
