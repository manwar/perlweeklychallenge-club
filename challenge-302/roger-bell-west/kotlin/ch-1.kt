fun onesandzeroes(a: List<String>, zeroes: Int, ones: Int): Int {
    var ax = ArrayList<Pair<Int, Int>>()
    for (ns in a) {
        var o = 0
        var n = 0
        for (c in ns) {
            when (c) {
                '0' -> { o += 1 }
                '1' -> { n += 1 }
            }
        }
        ax.add(Pair(o, n))
    }
    var mx = 0
    for (mask in 1 .. (1 shl ax.size)-1) {
        var o = 0
        var n = 0
        var ct = 0
        ax.forEachIndexed{i, x ->
                              if (mask and (1 shl i) > 0) {
                                  o = o + x.first
                                  n = n + x.second
                                  ct += 1
                              }
                          if (o <= zeroes && n <= ones) {
                              mx = listOf(mx, ct).maxOrNull()!!
                          }
        }
    }
    return mx
}

fun main() {

    if (onesandzeroes(listOf("10", "0001", "111001", "1", "0"), 5, 3) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (onesandzeroes(listOf("10", "1", "0"), 1, 1) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
