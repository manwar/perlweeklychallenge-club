fun sortcolumn(a: List<String>): Int {
    var vv = ArrayList<ArrayList<Char>>()
    a.forEachIndexed {i, s ->
                      s.toList().forEachIndexed { j, c ->
                                                if (i == 0) {
                                                    vv.add(ArrayList<Char>())
                                                }
                                                vv[j].add(c)
                      }
    }
    var tot = 0
    for (x in vv) {
        var y = x.sorted()
        if (x != y) {
            tot += 1
        }
    }
    return tot
}

fun main() {

    if (sortcolumn(listOf("swpc", "tyad", "azbe")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortcolumn(listOf("cba", "daf", "ghi")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortcolumn(listOf("a", "b", "c")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
