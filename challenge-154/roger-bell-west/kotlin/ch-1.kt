fun permute(aa: List<Char>): MutableSet<String> {
    var a=mutableListOf<Char>()
    for (i in aa) {
        a.add(i)
    }
    var out=mutableSetOf<String>()
    val n=a.size
    var c=ArrayList<Int>();
    for (i in 0..n-1) {
        c.add(0)
    }
    out.add(String(a.toCharArray()))
    var i=0
    while (true) {
        if (i>= n) {
            break
        }
        if (c[i] < i) {
            if (i % 2 == 0) {
                val tmp = a[0]
                a[0] = a[i]
                a[i] = tmp
            } else {
                val tmp = a[c[i]]
                a[c[i]] = a[i]
                a[i] = tmp
            }
            out.add(String(a.toCharArray()))
            c[i] += 1
            i = 0
        } else {
            c[i] = 0
            i += 1
        }
    }
    return out
}

fun missingpermutations(list: List<String>): ArrayList<String> {
    var l0=list[0].toMutableList();
    var perms=permute(l0)
    for (i in list) {
        perms.remove(i)
    }
    return ArrayList(perms)
}

fun main() {
    if (missingpermutations(listOf("PELR", "PREL", "PERL", "PRLE",
                                   "PLER", "PLRE", "EPRL", "EPLR",
                                   "ERPL", "ERLP", "ELPR", "ELRP",
                                   "RPEL", "RPLE", "REPL", "RELP",
                                   "RLPE", "RLEP", "LPER", "LPRE",
                                   "LEPR", "LRPE", "LREP")) ==
                                listOf("LERP")) {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
