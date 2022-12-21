fun rangelist(l: List<Int>): List<List<Int>> {
    var o = ArrayList<List<Int>>()
    var start = l[0]
    var prev = start
    for (v in l.drop(1)) {
        if (v != prev + 1) {
            if (prev > start) {
                o.add(listOf(start, prev))
            }
            start = v
        }
        prev = v
    }
    if (prev > start) {
        o.add(listOf(start, prev))
    }
    return o.toList()
}

fun main() {
    if (rangelist(listOf(1, 3, 4, 5, 7)) == listOf(listOf(3, 5))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (rangelist(listOf(1, 2, 3, 6, 7, 9)) ==
            listOf(listOf(1, 3), listOf(6, 7))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (rangelist(listOf(0, 1, 2, 4, 5, 6, 8, 9)) ==
            listOf(listOf(0, 2), listOf(4, 6), listOf(8, 9))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
