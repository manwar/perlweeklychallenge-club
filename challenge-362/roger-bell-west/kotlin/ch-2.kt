fun spellboundsorting(a: List<Int>): List<Int> {
    return a.sortedBy { x: Int -> towords(x) }
}

fun towords(a: Int): String {
    if (a == 0) {
        return "zero"
    }
    var components = ArrayList<String>()
    var b = a
    if (a < 0) {
        b = -a
        components.add("minus")
    }
    val vw = listOf(
        Pair(1000000000, "milliard"),
        Pair(1000000, "million"),
        Pair(1000, "thousand"),
        Pair(100, "hundred"),
        Pair(90, "ninety"),
        Pair(80, "eighty"),
        Pair(70, "seventy"),
        Pair(60, "sixty"),
        Pair(50, "fifty"),
        Pair(40, "forty"),
        Pair(30, "thirty"),
        Pair(20, "twenty"),
        Pair(19, "nineteen"),
        Pair(18, "eighteen"),
        Pair(17, "seventeen"),
        Pair(16, "sixteen"),
        Pair(15, "fifteen"),
        Pair(14, "fourteen"),
        Pair(13, "thirteen"),
        Pair(12, "twelve"),
        Pair(11, "eleven"),
        Pair(10, "ten"),
        Pair(9, "nine"),
        Pair(8, "eight"),
        Pair(7, "seven"),
        Pair(6, "six"),
        Pair(5, "five"),
        Pair(4, "four"),
        Pair(3, "three"),
        Pair(2, "two"),
        Pair(1, "one")
    )
    for (w in cw(b, vw)) {
        components.add(w)
    }
    return components.joinToString(" ")
}

fun cw(n: Int, vw: List<Pair<Int, String>>): List<String> {
    var res = ArrayList<String>()
    for ((vl, word) in vw) {
        if (n >= vl) {
            var andflag = false
            if (n >= 100) {
                andflag = true
                for (w in cw(n / vl, vw)) {
                    res.add(w)
                }
            }
            res += word
            val p = n % vl
            if (p > 0) {
                if (andflag) {
                    res.add("and")
                }
                for (w in cw(p, vw)) {
                    res.add(w)
                }
            }
            break
        }
    }
    return res.toList()
}

fun main() {

    if (spellboundsorting(listOf(6, 7, 8, 9, 10)) == listOf(8, 9, 7, 6, 10)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (spellboundsorting(listOf(-3, 0, 1000, 99)) == listOf(-3, 99, 1000, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (spellboundsorting(listOf(1, 2, 3, 4, 5)) == listOf(5, 4, 1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (spellboundsorting(listOf(0, -1, -2, -3, -4)) == listOf(-4, -1, -3, -2, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (spellboundsorting(listOf(100, 101, 102)) == listOf(100, 101, 102)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
