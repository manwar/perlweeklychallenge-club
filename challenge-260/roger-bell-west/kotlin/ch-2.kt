fun permute(aa: List<Char>): ArrayList<List<Char>> {
    var a = ArrayList<Char>()
    for (i in aa) {
        a.add(i)
    }
    var out = ArrayList<List<Char>>()
    val n = a.size
    var c = ArrayList<Int>();
    for (i in 0..n-1) {
        c.add(0)
    }
    out.add(a.toList())
    var i = 0
    while (true) {
        if (i >= n) {
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
            out.add(a.toList())
            c[i] += 1
            i = 0
        } else {
            c[i] = 0
            i += 1
        }
    }
    return out
}

fun dictionaryrank(a: String): Int {
    val c = a.toCharArray().toList()
    var d = mutableSetOf<String>()
    for (o in permute(c)) {
        d.add(o.joinToString(""))
    }
    var dd = ArrayList(d)
    dd.sort()
    var r = 0
    dd.forEachIndexed{i, s ->
                          if (s == a) {
                              r = i + 1
                          }
    }
    return r
}

fun main() {

    if (dictionaryrank("CAT") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (dictionaryrank("GOOGLE") == 88) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (dictionaryrank("SECRET") == 255) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
