fun similarwords(a: List<String>): Int {
    var ct = mutableMapOf<Int, Int>().withDefault({0})
    val ac = 'a'.code
    for (w in a) {
        var hs = w.toCharArray().toSet()
        var mask = 0
        for (c in hs) {
            mask = mask or (1 shl (c.code - ac))
        }
        ct.set(mask, ct.getValue(mask) + 1)
    }
    var pairs = 0
    for (cv in ct.values) {
        if (cv > 1) {
            pairs += cv * (cv - 1) / 2
        }
    }
    return pairs
}

fun main() {

    if (similarwords(listOf("aba", "aabb", "abcd", "bac", "aabc")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (similarwords(listOf("aabb", "ab", "ba")) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (similarwords(listOf("nba", "cba", "dba")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
