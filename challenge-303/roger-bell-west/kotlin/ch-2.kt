fun deleteandearn(a: List<Int>): Int {
    var ct = mutableMapOf<Int, Int>().withDefault({0})
    for (c in a) {
        ct.set(c, ct.getValue(c) + 1)
    }
    var mx = 0
    var stack = ArrayList<Pair<Map<Int, Int>, Int>>()
    stack.add(Pair(ct, 0))
    while (stack.size > 0) {
        val c = stack.removeLast()
        if (c.first.size == 0) {
            mx = listOf(mx, c.second).maxOrNull()!!
        } else {
            for (d in c.first.keys) {
                var cc = mutableMapOf<Int, Int>().withDefault({0})
                for (cx in c.first.keys) {
                    cc.set(cx, c.first.getValue(cx))
                }
                cc.set(d, cc.getValue(d) - 1)
                if (cc.getValue(d) == 0) {
                    cc.remove(d)
                }
                cc.remove(d + 1)
                cc.remove(d - 1)
                stack.add(Pair(cc, c.second + d))
            }
        }
    }
    return mx
}

fun main() {

    if (deleteandearn(listOf(3, 4, 2)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (deleteandearn(listOf(2, 2, 3, 3, 3, 4)) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
