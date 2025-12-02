fun counterify(a: List<Char>): Map<Char, Int> {
    var cc = mutableMapOf<Char, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun countdigits(a: Int): Map<Char, Int> {
    return counterify(a.toString().toList())
}

fun shufflepairs(low: Int, high: Int, pairs: Int): Int {
    var total = 0
    for (candidate in low .. high) {
        val candidatec = countdigits(candidate)
        var cnt = 0
        for (mul in 2 .. 9) {
            val test = candidate * mul
            val testc = countdigits(test)
            if (testc == candidatec) {
                cnt++
                if (cnt >= pairs) {
                    break
                }
            }
        }
        if (cnt >= pairs) {
            total++
        }
    }
    return total
}

fun main() {

    if (shufflepairs(1, 1000, 1) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shufflepairs(1500, 2500, 1) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shufflepairs(1000000, 1500000, 5) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shufflepairs(13427000, 14100000, 2) == 11) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shufflepairs(1000, 5000, 1) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
