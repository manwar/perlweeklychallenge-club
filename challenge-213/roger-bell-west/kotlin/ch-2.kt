fun shortestroute(r0: List<List<Int>>, origin: Int, destination: Int): List<Int> {
    var r = mutableMapOf<Int, MutableSet<Int>>()
    for (rt in r0) {
        for (rp in rt.windowed(size = 2)) {
            if (!r.contains(rp[0])) {
                r.put(rp[0], mutableSetOf<Int>())
            }
            r.get(rp[0])!!.add(rp[1])
            if (!r.contains(rp[1])) {
                r.put(rp[1], mutableSetOf<Int>())
            }
            r.get(rp[1])!!.add(rp[0])
        }
    }
    var out = ArrayList<Int>()
    var stack = ArrayDeque<ArrayList<Int>>()
    stack.add(arrayListOf(origin))
    while (stack.size > 0) {
        val s = stack.removeFirst()
        val l = s.last()
        if (l == destination) {
            out = s
            break
        } else {
            val s1 = s.toSet()
            for (pd in r.get(l)!!) {
                if (!s1.contains(pd)) {
                    var q = ArrayList(s)
                    q.add(pd)
                    stack.add(q)
                }
            }
        }
    }
    return out.toList()
}


fun main() {

    if (shortestroute(listOf(listOf(1, 2, 6), listOf(5, 6, 7)), 1, 7) == listOf(1, 2, 6, 7)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shortestroute(listOf(listOf(1, 2, 3), listOf(4, 5, 6)), 2, 5) == emptyList<List<Int>>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shortestroute(listOf(listOf(1, 2, 3), listOf(4, 5, 6), listOf(3, 8, 9), listOf(7, 8)), 1, 7) == listOf(1, 2, 3, 8, 7)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
