fun pattern132(l: List<Int>): List<Int> {
    var o = ArrayList<Int>()
    for (a in 0..l.size-3) {
       for (b in a+1..l.size-2) {
            if (l[a] < l[b]) {
                for (c in b+1..l.size-1) {
                    if (l[b] > l[c] && l[a] < l[c]) {
                        o = arrayListOf(l[a], l[b], l[c])
                        break
                    }
                }
            }
            if (o.size > 0) {
                break
            }
        }
        if (o.size > 0) {
            break
        }
    }
    return o.toList()
}

fun main() {
    if (pattern132(listOf(3, 1, 4, 2)) == listOf(1, 4, 2)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (pattern132(listOf(1, 2, 3, 4)) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (pattern132(listOf(1, 3, 2, 4, 6, 5)) == listOf(1, 3, 2)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (pattern132(listOf(1, 3, 4, 2)) == listOf(1, 3, 2)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
