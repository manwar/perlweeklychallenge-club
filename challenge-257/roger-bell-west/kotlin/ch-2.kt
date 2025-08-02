
fun reducedrowechelon(a: List<List<Int>>): Boolean {
    var leadingone = ArrayList<Int>()
    var valid = true
    for (row in a) {
        var lp = -1
        row.forEachIndexed{cn, cell ->
                               if (lp == -1) {
                                   if (cell == 1) {
                                       lp = cn
                                   } else if (cell != 0) {
                                       valid = false
                                   }
                               }
        }
        leadingone.add(lp)
        if (!valid) {
            return false
        }
    }
    while (leadingone[leadingone.size-1] == -1) {
        leadingone.removeLast()
    }
    var c = ArrayList(leadingone)
    c.sort()
    if (c[0] == -1) {
        return false
    }
    if (c !=  leadingone) {
        return false
    }
    for (i in c) {
        var col = ArrayList(a.map { it[i] })
        col.sort()
        if (col[col.size-1] != 1 ||
            col[col.size-2] != 0 ||
            col[0] != 0) {
            return false
        }
    }
    return true
}

fun main() {

    if (!reducedrowechelon(listOf(listOf(1, 1, 0), listOf(0, 1, 0), listOf(0, 0, 0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reducedrowechelon(listOf(listOf(0, 1, -2, 0, 1), listOf(0, 0, 0, 1, 3), listOf(0, 0, 0, 0, 0), listOf(0, 0, 0, 0, 0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reducedrowechelon(listOf(listOf(1, 0, 0, 4), listOf(0, 1, 0, 7), listOf(0, 0, 1, -1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(listOf(listOf(0, 1, -2, 0, 1), listOf(0, 0, 0, 0, 0), listOf(0, 0, 0, 1, 3), listOf(0, 0, 0, 0, 0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(listOf(listOf(0, 1, 0), listOf(0, 1, 0), listOf(0, 0, 0)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(listOf(listOf(4, 0, 0, 0), listOf(0, 1, 0, 7), listOf(0, 0, 1, -1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(listOf(listOf(1, 0, 0, 4), listOf(1, 0, 0, 7), listOf(0, 0, 1, -1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!reducedrowechelon(listOf(listOf(1, -2, 0, 4), listOf(0, 1, 0, 7), listOf(0, 0, 1, -1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
