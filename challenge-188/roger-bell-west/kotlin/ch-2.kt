fun totalzero(aa: Int, bb: Int): Int {
    if (aa == 0 && bb == 0) {
        return 0
    }
    var a = aa
    var b = bb
    var ct = 1
    while (true) {
        if (a == b) {
            return ct
        }
        ct += 1
        if (a > b) {
            a -= b
        } else {
            b -= a
        }
    }
}

fun main() {
    if (totalzero(5, 4) == 5) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (totalzero(4, 6) == 3) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (totalzero(2, 5) == 4) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (totalzero(3, 1) == 3) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (totalzero(7, 4) == 5) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
