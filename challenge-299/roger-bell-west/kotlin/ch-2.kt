fun wordsearch(grid0: List<List<Char>>, word0: String): Boolean {
    var grid = mutableMapOf<Pair<Int, Int>, Char>()
    grid0.forEachIndexed{y, row ->
                             row.forEachIndexed{x, c ->
                                                    grid[Pair(x, y)] = c
                             }
    }
    val word = word0.toCharArray()
    for ((start, firstletter) in grid) {
        if (firstletter == word[0]) {
            var queue = ArrayDeque<ArrayList<Pair<Int, Int>>>()
            queue.add(ArrayList(listOf(start)))
            while (queue.size > 0) {
                val pos = queue.removeFirst()
                if (pos.size == word.size) {
                    return true
                } else {
                    for (dir in listOf(Pair(0, 1), Pair(1, 0), Pair(0, -1), Pair(-1, 0))) {
                        val lpos = pos.last()
                        val npos = Pair(lpos.first + dir.first, lpos.second + dir.second)
                        if (grid.contains(npos) &&
                            !pos.contains(npos) &&
                            grid[npos] == word[pos.size]) {
                            var pp = ArrayList(pos)
                            pp.add(npos)
                            queue.add(pp)
                        }
                    }
                }
            }
        }
    }
    return false
}

fun main() {

    if (wordsearch(listOf(listOf('A', 'B', 'D', 'E'), listOf('C', 'B', 'C', 'A'), listOf('B', 'A', 'A', 'D'), listOf('D', 'B', 'B', 'C')), "BDCA")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!wordsearch(listOf(listOf('A', 'A', 'B', 'B'), listOf('C', 'C', 'B', 'A'), listOf('C', 'A', 'A', 'A'), listOf('B', 'B', 'B', 'B')), "ABAC")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordsearch(listOf(listOf('B', 'A', 'B', 'A'), listOf('C', 'C', 'C', 'C'), listOf('A', 'B', 'A', 'B'), listOf('B', 'B', 'A', 'A')), "CCCAA")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
