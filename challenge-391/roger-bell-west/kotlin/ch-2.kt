fun arrangebox(a0: List<List<Int>>): Int {
    val customComparator = Comparator {
        i: List<Int>, j: List<Int> ->
            val kx = listOf(i.size, j.size).minOrNull()!!
        var k = 0
        while (k < kx - 1) {
            if (i[k] == j[k]) {
                k += 1
            } else {
                break;
            }
        }
        val cmp = i[k] - j[k]
        if (cmp < 0) {
            -1
        } else if (cmp > 0) {
            1
        } else {
            0
        }
    }
    val a = a0.sortedWith(customComparator).toList()
    var stack = ArrayList<Pair<Int, Int>>()
    var mx = 1
    for (i in 0 .. a.size - 1) {
        stack += Pair(i, 1)
    }
    while (stack.size > 0) {
        val (ix, pm) = stack.removeAt(stack.lastIndex)
        if (pm > mx) {
            mx = pm
        }
        for (j in ix + 1 .. a.size - 1) {
            if (a[ix][0] < a[j][0] && a[ix][1] < a[j][1]) {
                stack.add(Pair(j, pm + 1))
            }
        }
    }
    return mx
}

fun main() {

    if (arrangebox(listOf(listOf(1, 3), listOf(3, 5), listOf(6, 8), listOf(2, 4))) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arrangebox(listOf(listOf(4, 5), listOf(4, 6), listOf(6, 7), listOf(2, 3), listOf(4, 3))) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arrangebox(listOf(listOf(5, 5), listOf(5, 5), listOf(5, 5))) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arrangebox(listOf(listOf(2, 100), listOf(3, 200), listOf(4, 300), listOf(5, 50), listOf(5, 400))) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (arrangebox(listOf(listOf(10, 20), listOf(15, 10), listOf(20, 30), listOf(12, 18), listOf(16, 25))) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
