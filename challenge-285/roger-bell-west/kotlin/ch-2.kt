fun nAryCartesianProduct(lists: List<List<Int>>): List<List<Int>> {
    var c = ArrayList<Int>()
    var cm = ArrayList<Int>()
    for (i in lists) {
        cm.add(i.size - 1)
        c.add(0)
    }
    var out = ArrayList<List<Int>>()
    var ex = false
    while (!ex) {
        var o = ArrayList<Int>()
        for (i in 0..c.size - 1) {
            o.add(lists[i][c[i]])
        }
        out.add(o.toList())
        var ss = c.size-1
        while (true) {
            c[ss] += 1
            if (c[ss] > cm[ss]) {
                if (ss == 0) {
                    ex = true
                    break
                }
                c[ss] = 0
                ss--
            } else {
                break
            }
        }
    }
    return out.toList()
}

fun makingchange(a: Int): Int {
    val coins = listOf(1, 5, 10, 25, 50)
    val max = coins.map{a / it}
    var pat = ArrayList<List<Int>>()
    for (i in 0..coins.size - 1) {
        if (max[i] > 0) {
            pat.add((0..max[i]).toList())
        } else {
            break
        }
    }
    var ct = 0
    for (combo in nAryCartesianProduct(pat)) {
        var t = 0
        combo.forEachIndexed{i, c ->
                             t += c * coins[i]
        }
        if (t == a) {
            ct += 1
        }
    }
    return ct
}

fun main() {

    if (makingchange(9) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (makingchange(15) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (makingchange(100) == 292) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
