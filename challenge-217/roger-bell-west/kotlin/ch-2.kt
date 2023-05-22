fun maxnumber(lst: List<Int>): Int {
    val po = lst.map {it.toString()}
    val pl = po.map {it.length}.maxOrNull()!!
    var pm = ArrayList<String>()
    for (so in po) {
        var sm = so
        if (so.length < pl) {
            val c = so.lastOrNull()!!
            for (_i in 1 .. pl - so.length) {
                sm += c
            }
        }
        pm.add(sm)
    }
    var pi = ArrayList((0 .. pm.size - 1).toList())
    pi.sortByDescending {pm[it]}
    var out = ""
    for (st in pi) {
        out += po[st]
    }
    return out.toInt()
}

fun main() {

    if (maxnumber(listOf(1, 23)) == 231) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxnumber(listOf(10, 3, 2)) == 3210) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxnumber(listOf(31, 2, 4, 10)) == 431210) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxnumber(listOf(5, 11, 4, 1, 2)) == 542111) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxnumber(listOf(1, 10)) == 110) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
