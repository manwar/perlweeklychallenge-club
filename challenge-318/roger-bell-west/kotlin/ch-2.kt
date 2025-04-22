fun reverseequals(a: List<Int>, b: List<Int>): Boolean {
    if (a == b) {
        return true
    }
    for (i in 0 .. a.size - 3) {
        for (j in i + 1 .. a.size - 2) {
            var c = ArrayList(a)
            for (x in i .. j) {
                c[x] = a[j - (x - i)]
            }
            if (c == b) {
                return true
            }
        }
    }
    return false
}

fun main() {

    if (reverseequals(listOf(3, 2, 1, 4), listOf(1, 2, 3, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!reverseequals(listOf(1, 3, 4), listOf(4, 1, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseequals(listOf(2), listOf(2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
