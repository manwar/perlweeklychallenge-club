fun alternatecase(a: String): Int {
    val uppers = a.toList().map{it.isUpperCase()}.toList()
    var queue = ArrayDeque<Pair<List<Boolean>, Int>>()
    queue.add(Pair(uppers, 0))
    while (queue.size > 0) {
        val (up, ct) = queue.removeAt(0)
        var swaps = ArrayList<Int>()
        for (i in 0 .. up.size - 2) {
            if (up[i] == up[i + 1]) {
                if (i > 0) {
                    swaps.add(i - 1)
                }
                if (i < up.size - 2) {
                    swaps.add(i + 1)
                }
            }
        }
        if (swaps.size == 0) {
            return ct
        } else {
            for (sw in swaps) {
                var uq = ArrayList(up)
                val tmp = uq[sw]
                uq[sw] = uq[sw + 1]
                uq[sw + 1] = tmp
                queue.add(Pair(uq.toList(), ct + 1))
            }
        }
    }
    return 0
}

fun main() {

    if (alternatecase("aAbB") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatecase("AAbb") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatecase("AAAbbb") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatecase("aABb") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatecase("bBBAaa") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
