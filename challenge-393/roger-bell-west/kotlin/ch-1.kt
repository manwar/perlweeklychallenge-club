fun pythagorasmultiplied(n: Int): Int {
    var ct = 0
    for (c in 5 .. n) {
        val csquared = c * c
        for (a in 1 .. c - 2) {
            val asquared = a * a
            for (b in a + 1 .. c - 1) {
                val bsquared = b * b
                val tot = asquared + bsquared
                if (tot > csquared) {
                    break
                }
                if (tot == csquared) {
                    ct += 1
                }
            }
        }
    }
    return ct * 2
}

fun main() {

    if (pythagorasmultiplied(20) == 12) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(7) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(1) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(15) == 8) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (pythagorasmultiplied(30) == 22) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
