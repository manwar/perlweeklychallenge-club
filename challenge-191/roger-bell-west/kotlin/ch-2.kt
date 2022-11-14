fun cutelist(n: Int): Int {
    var tab = ArrayList<ArrayList<Boolean>>()
    tab.add(arrayListOf(false))
    for (x in 1..n) {
        var row = ArrayList<Boolean>()
        for (y in 1..n+1) {
            row.add(false)
        }
        tab.add(row)
    }
    for (x in 1..n) {
        for (y in 1..x) {
            if (x % y != 0 && y % x != 0) {
                tab[x][y] = true
                tab[y][x] = true
            }
        }
    }
    var count = 0
    var stackl = ArrayList<ArrayList<Int>>()
    stackl.add(arrayListOf())
    var stackc = ArrayList<ArrayList<Int>>()
    stackc.add(ArrayList((1..n).toList()))
    while (stackl.size > 0) {
        val l = stackl.last()
        stackl = ArrayList(stackl.dropLast(1))
        val c = stackc.last()
        stackc = ArrayList(stackc.dropLast(1))
        if (c.size == 0 && l.size == n) {
            count += 1
        } else {
            val place = l.size + 1
            for (candidate in c) {
                if (!tab[place][candidate]) {
                    var q = ArrayList(l)
                    q.add(candidate)
                    stackl.add(q)
                    stackc.add(ArrayList(c.filter{it != candidate}))
                }
            }
        }
    }
    return count
}

fun main() {
    if (cutelist(2) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (cutelist(10) == 700) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (cutelist(15) == 24679) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
