fun busroute(a: List<List<Int>>): List<Int> {
    var route = ArrayList<Map<Int, Int>>()
    for (rt in a) {
        var ri = mutableMapOf<Int, Int>()
        val interval = rt[0]
        val offset = rt[1]
        val duration = rt[2]
        var start = offset
        while (start <= 60 + offset) {
            ri.put(start, start + duration)
            start += interval
        }
        route.add(ri)
    }
    var out = ArrayList<Int>()
    for (t in 0 .. 59) {
        var best = mutableSetOf<Int>()
        var at = -1
        var nxt = mutableSetOf<Int>()
        var ndt = -1
        route.forEachIndexed {i, r ->
                                  val nb = r.keys.filter{it >= t}.minOrNull()!!
                              val nt = r.getValue(nb)
                              if (at == -1 || nt < at) {
                                  best = mutableSetOf<Int>()
                                  at = nt
                              }
                              if (nt <= at) {
                                  best.add(i)
                              }
                              if (ndt == -1 || nb < ndt) {
                                  nxt = mutableSetOf<Int>()
                                  ndt = nb
                              }
                              if (nb <= ndt) {
                                  nxt.add(i)
                              }
        }
        if (best.intersect(nxt).isEmpty()) {
            out.add(t)
        }
    }
    return out.toList()
}

fun main() {

    if (busroute(listOf(listOf(12, 11, 41), listOf(15, 5, 35))) == listOf(36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (busroute(listOf(listOf(12, 3, 41), listOf(15, 9, 35), listOf(30, 5, 25))) == listOf(0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
