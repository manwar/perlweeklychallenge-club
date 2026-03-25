fun validtimes(a: String): Int {
    var combinator = ArrayList<List<Int>>()
    for ((i, c) in a.asSequence().withIndex() ) {
        if (c.isDigit()) {
            combinator.add(listOf(c.digitToInt()))
        } else {
            val j = when (i) {
                0 -> 2
                1, 4 -> 9
                3 -> 5
                else -> 0
            }
            if (j > 0) {
                var p = ArrayList<Int>()
                for (x in 0 .. j) {
                    p.add(x)
                }
                combinator.add(p.toList())
            }
        }
    }
    if (combinator.size != 4) {
        return 0
    }
    val minutes = combinator[2].size * combinator[3].size
    var ct = 0
    for (ax in combinator[0]) {
        for (bx in combinator[1]) {
            if (ax * 10 + bx <= 23) {
                ct += 1
            }
        }
    }
    return ct * minutes
}

fun main() {

    if (validtimes("?2:34") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validtimes("?4:?0") == 12) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validtimes("??:??") == 1440) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validtimes("?3:45") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validtimes("2?:15") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
