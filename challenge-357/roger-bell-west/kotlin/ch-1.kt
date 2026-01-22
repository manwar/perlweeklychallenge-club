fun a2n(a: List<Int>): Int {
    var t = 0
    for (d in a) {
        t *= 10
        t += d
    }
    return t
}

fun kaprekarconstant(a: Int): Int {
    var ct = 0
    var b = a
    while (b != 6174) {
        if (b == 0) {
            return -1
        }
        var digits = ArrayList<Int>()
        for (i in 0 .. 3) {
            digits.add(b % 10)
            b /= 10
        }
        digits.sort();
        val stigid = digits.asReversed()
        b = a2n(stigid) - a2n(digits)
        ct += 1
    }
    return ct
}

fun main() {

    if (kaprekarconstant(3524) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (kaprekarconstant(6174) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (kaprekarconstant(9998) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (kaprekarconstant(1001) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (kaprekarconstant(9000) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (kaprekarconstant(1111) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
