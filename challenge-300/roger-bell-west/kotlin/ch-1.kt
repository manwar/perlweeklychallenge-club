fun beautifularrangement(a: Int): Int {
    var precalc = ArrayList((1 .. a + 1).map{ArrayList((1 .. a + 1).map{false})})
    for (i in 1 .. a) {
        for (j in i .. a step i) {
            precalc[i][j] = true
            precalc[j][i] = true
        }
    }
    var ct = 0
    var stack = ArrayList<List<Int>>()
    stack.add((1 .. a).toList())
    while (stack.size > 0) {
        val trail = stack.removeLast()
        if (trail.size == 1) {
            ct += 1
        } else {
            val p = a - trail.size + 2
            for (i in trail) {
                if (precalc[i][p]) {
                    val tt = trail.filter{it != i}.toList()
                    stack.add(tt)
                }
            }
        }
    }
    return ct
}

fun main() {

    if (beautifularrangement(2) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (beautifularrangement(1) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (beautifularrangement(10) == 700) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (beautifularrangement(20) == 1939684) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
