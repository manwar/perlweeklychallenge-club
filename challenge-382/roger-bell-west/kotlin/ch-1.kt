fun isqrt(s: Int): Int {
    if (s <= 1) {
        return s
    } else {
        var x0 = s / 2
        var x1 = (x0 + s / x0) / 2
        while (x1 < x0) {
            x0 = x1
            x1 = (x0 + s / x0) / 2
        }
        return x0
    }
}

fun is_adjacentsquares(param: Int, hc: List<Int>): Boolean {
    val hcs = hc.sorted()
    if ((1 .. param).toList() != hcs) {
        println("bad hcs")
        return false
    }
    for (i in 0 .. param - 2) {
        val pn = hc[i] + hc[i + 1]
        val sn = isqrt(pn)
        if (pn != sn * sn) {
            println("bad pn")
            return false
        }
    }
    val pn = hc[0] + hc[hc.size - 1]
    val sn = isqrt(pn * pn)
    if (pn != sn) {
        println("bad span")
        return false
    }
    return true
}

fun hamiltoniancycle(a: Int): List<Int> {
    if (a < 31) {
        return emptyList<Int>()
    }
    var perfectsquares = mutableSetOf<Int>()
    for (p in 1 .. a) {
        perfectsquares.add(p * p)
    }
    var neighbours = mutableMapOf<Int, MutableSet<Int>>()
    for (x in 1..a) {
        for (y in perfectsquares) {
            if (y > x) {
                val z = y - x
                if (z <= a) {
                    if (!neighbours.containsKey(x)) {
                        neighbours[x] = mutableSetOf<Int>()
                    }
                    neighbours[x]!!.add(z)
                    if (!neighbours.containsKey(z)) {
                        neighbours[z] = mutableSetOf<Int>()
                    }
                    neighbours[z]!!.add(x)
                }
            }
        }
    }
    var stack = ArrayList<List<Int>>()
    stack.add(listOf(1))
    while (stack.size > 0) {
        val lst = stack.removeAt(stack.lastIndex)
        if (lst.size == a) {
            if (perfectsquares.contains(lst[0] + lst[lst.lastIndex])) {
                return lst
            }
        } else {
            for (candidate in neighbours[lst[lst.size - 1]]!!) {
                if (!lst.contains(candidate)) {
                    stack.add(lst + candidate)
                }
            }
        }
    }
    return emptyList<Int>()
}

fun main() {

    if (is_adjacentsquares(32, hamiltoniancycle(32))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (hamiltoniancycle(15) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (is_adjacentsquares(34, hamiltoniancycle(34))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
