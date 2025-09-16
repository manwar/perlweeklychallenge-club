fun maxdiff(a: List<Int>): Int {
    var md = 0
    for (w in 0 .. a.size - 2) {
        for (x in w + 1 .. a.size - 1) {
            for (y in w + 1 .. a.size - 2) {
                if (y != x) {
                    for (z in y + 1 .. a.size - 1) {
                        if (z != x) {
                            val v = Math.abs(a[w] * a[x] - a[y] * a[z])
                            md = listOf(md, v).maxOrNull()!!
                        }
                    }
                }
            }
        }
    }
    return md
}

fun main() {

    if (maxdiff(listOf(5, 9, 3, 4, 6)) == 42) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdiff(listOf(1, -2, 3, -4)) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdiff(listOf(-3, -1, -2, -4)) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdiff(listOf(10, 2, 0, 5, 1)) == 50) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxdiff(listOf(7, 8, 9, 10, 10)) == 44) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
