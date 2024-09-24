fun contiguousblock(a: List<List<Char>>): Int {
    val y = a.size
    val x = a[0].size
    var starts = mutableSetOf<Pair<Int, Int>>()
    for (cx in 0..x - 1) {
        for (cy in 0..y - 1) {
            starts.add(Pair(cx, cy))
        }
    }
    var maxblock = 0
    while (starts.size > 0) {
        val start = starts.toList()[0]
        var queue = ArrayDeque<Pair<Int, Int>>()
        var visited = mutableSetOf<Pair<Int, Int>>()
        visited.add(start)
        queue.add(start)
        while (queue.size > 0) {
            val here = queue.removeFirst()
            for (delta in listOf(Pair(-1, 0), Pair(1, 0), Pair(0, -1), Pair(0, 1))) {
                if ((delta.first >= 0 || here.first > 0) &&
                (delta.first <= 0 || here.first < x - 1) &&
                (delta.second >= 0 || here.second > 0) &&
                (delta.second <= 0 || here.second < y - 1)) {
                    val there = Pair(here.first + delta.first, here.second + delta.second)
                    if (!visited.contains(there)
                    && a[there.second ][there.first]
                        == a[start.second][start.first]) {
                        visited.add(there)
                        queue.add(there)
                    }
                }
            }
        }
        val sz = visited.size
        if (sz > maxblock) {
            maxblock = sz
        }
        starts -= visited
    }
    return maxblock
}

fun main() {

    if (contiguousblock(listOf(listOf('x', 'x', 'x', 'x', 'o'), listOf('x', 'o', 'o', 'o', 'o'), listOf('x', 'o', 'o', 'o', 'o'), listOf('x', 'x', 'x', 'o', 'o'))) == 11) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(' ')
    if (contiguousblock(listOf(listOf('x', 'x', 'x', 'x', 'x'), listOf('x', 'o', 'o', 'o', 'o'), listOf('x', 'x', 'x', 'x', 'o'), listOf('x', 'o', 'o', 'o', 'o'))) == 11) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(' ')
    if (contiguousblock(listOf(listOf('x', 'x', 'x', 'o', 'o'), listOf('o', 'o', 'o', 'x', 'x'), listOf('o', 'x', 'x', 'o', 'o'), listOf('o', 'o', 'o', 'x', 'x'))) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
