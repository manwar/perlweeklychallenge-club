fun arraydegree(a: List<Int>): List<Int> {
    var f = mutableMapOf<Int, Int>()
    for (x in a) {
        if (f.containsKey(x)) {
            f[x] = f[x]!! + 1
        } else {
            f[x] = 1
        }
    }
    val degree = f.values.maxOrNull()!!
    var inverse = mutableMapOf<Int, MutableList<Int>>()
    for ((i, x) in a.withIndex()) {
        if (inverse.containsKey(x)) {
            inverse[x]!!.add(i)
        } else {
            inverse[x] = mutableListOf(i)
        }
    }
    var minlen = 1 + a.size
    var se = listOf(0, 1)
    for (n in f.keys) {
        if (f[n]!! == degree) {
            val ll = 1 + inverse[n]!![inverse[n]!!.size-1] - inverse[n]!![0]
            if (ll < minlen) {
                minlen = ll
                se = listOf(inverse[n]!![0], inverse[n]!![inverse[n]!!.size-1])
            }
        }
    }
    return a.slice(se[0]..se[1])
}

fun main() {
    if (arraydegree(listOf(1, 3, 3, 2)) == listOf(3, 3)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (arraydegree(listOf(1, 2, 1, 3)) == listOf(1, 2, 1)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (arraydegree(listOf(1, 3, 2, 1, 2)) == listOf(2, 1, 2)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (arraydegree(listOf(1, 1, 2, 3, 2)) == listOf(1, 1)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (arraydegree(listOf(2, 1, 2, 1, 1)) == listOf(1, 2, 1, 1)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
