fun rearrangegroups(list: List<Int>, size: Int): List<List<Int>> {
    var h = mutableMapOf<Int, Int>()
    for (k in list) {
        if (h.contains(k)) {
            h[k] = h[k]!! + 1
        } else {
            h[k] = 1
        }
    }
    var out = ArrayList<List<Int>>()
    while (true) {
        val m = h.keys.minOrNull()!!
        val res = (m .. m + size - 1).toList()
        for (n in res) {
            if (h.contains(n)) {
                val p = h[n]!! - 1;
                if (p == 0) {
                    h.remove(n)
                } else {
                    h[n] = p
                }
            } else {
                return emptyList<List<Int>>()
            }
        }
        out.add(res)
        if (h.size == 0) {
            break
        }
    }
    return out.toList()
}

fun main() {

    if (rearrangegroups(listOf(1, 2, 3, 5, 1, 2, 7, 6, 3), 3) == listOf(listOf(1, 2, 3), listOf(1, 2, 3), listOf(5, 6, 7))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rearrangegroups(listOf(1, 2, 3), 2) == emptyList<List<Int>>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rearrangegroups(listOf(1, 2, 4, 3, 5, 3), 3) == listOf(listOf(1, 2, 3), listOf(3, 4, 5))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rearrangegroups(listOf(1, 5, 2, 6, 4, 7), 3) == emptyList<List<Int>>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
