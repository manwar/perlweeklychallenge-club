fun groupposition(a: String): List<String> {
    var mx = ArrayList<Pair<Char, Int>>()
    var lc = 'z'
    a.toCharArray().forEachIndexed {i, c ->
                                        if (i == 0) {
                                            lc = (c.code + 1).toChar()
                                        }
                                    if (lc == c) {
                                        val mc = mx.size
                                        mx[mc - 1] = Pair(mx[mc - 1].first, mx[mc - 1].second + 1)
                                    } else {
                                        mx += Pair(c, 1)
                                        lc = c
                                    }
    }
    var out = ArrayList<String>()
    for (ms in mx) {
        if (ms.second >= 3) {
            out.add(ms.first.toString().repeat(ms.second))
        }
    }
    return out.toList()
}

fun main() {

    if (groupposition("abccccd") == listOf("cccc")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (groupposition("aaabcddddeefff") == listOf("aaa", "dddd", "fff")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (groupposition("abcdd") == emptyList<String>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
