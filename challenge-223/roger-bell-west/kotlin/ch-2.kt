fun boxcoins(ints: List<Int>): Int {
    var mx = 0
    var stack = ArrayList<Pair<List<Int>, Int>>()
    stack.add(Pair(ints, 0))
    while (stack.size > 0) {
        val x = stack.removeLast()
        val t = x.first
        val tot = x.second
        if (tot > mx) {
            mx = tot
        }
        for (i in 0 .. t.size - 1) {
            var p = t[i]
            if (i > 0) {
                p *= t[i - 1]
            }
            if (i < t.size - 1) {
                p *= t[i + 1]
            }
            val stot = tot + p
            var tt = ArrayList<Int>()
            for (ix in 0 .. t.size - 1) {
                if (i != ix) {
                    tt.add(t[ix])
                }
            }
            stack.add(Pair(tt.toList(), stot))
        }
    }
    return mx
}

fun main() {

    if (boxcoins(listOf(3, 1, 5, 8)) == 167) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (boxcoins(listOf(1, 5)) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
