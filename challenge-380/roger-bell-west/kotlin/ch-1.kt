fun counterify(a: List<Char>): Map<Char, Int> {
    var cc = mutableMapOf<Char, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun sumoffrequencies(a: String): Int {
    var vw = 0
    var cn = 0
    val cc = counterify(a.toList())
    var cv = ArrayList(cc.values.toList())
    cv.sort()
    cv.reverse()
    for (n in cv) {
        for ((c, ni) in cc) {
            if (ni == n) {
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    if (vw == 0) {
                        vw = n
                    }
                } else {
                    if (cn == 0) {
                        cn = n
                    }
                }
                if (vw > 0 && cn > 0) {
                    break
                }
            }
        }
        if (vw > 0 && cn > 0) {
            break
        }
    }
    return vw + cn
}

fun main() {

    if (sumoffrequencies("banana") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumoffrequencies("teestett") == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumoffrequencies("aeiouuaa") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumoffrequencies("rhythm") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumoffrequencies("x") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
