fun cs2xy(a: String): Pair<Int, Int> {
    val c = a.toList()
    val x = c[0].code - 'a'.code
    val y = c[1].code - '1'.code
    return Pair(x, y)
}

fun knightsmove(from: String, to: String): Int {
    val fc = cs2xy(from)
    val tc = cs2xy(to)
    var queue = ArrayDeque<List<Int>>()
    queue.add(listOf(fc.first, fc.second, 0))
    var seen = mutableSetOf<Int>()
    while (queue.size > 0) {
        val cc = queue.removeFirst()
        if (cc[0] == tc.first && cc[1] == tc.second) {
            return cc[2]
        } else {
            for (offset in listOf (
                     listOf(2, 1),
                     listOf(1, 2),
                     listOf(2, -1),
                     listOf(1, -2),
                     listOf(-2, 1),
                     listOf(-1, 2),
                     listOf(-2, -1),
                     listOf(-1, -2)
            )) {
                val x = cc[0] + offset[0]
                val y = cc[1] + offset[1]
                if (x >= 0 && x <= 7 && y >= 0 && y <= 7) {
                    val cv = x * 8 + y
                    if (!seen.contains(cv)) {
                        queue.add(listOf(x, y, cc[2] + 1))
                        seen.add(cv)
                    }
                }
            }
        }
    }
    return -1
}

fun main() {

    if (knightsmove("g2", "a8") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (knightsmove("g2", "h2") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
