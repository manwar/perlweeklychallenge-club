fun l2n(a: String): Int {
    val a0 = 'a'.code
    var t = 0
    for (c in a.toList()) {
        t *= 10;
        t += c.code - a0;
    }
    return t
}

fun sumofwords(a: String, b: String, c: String): Boolean {
    return l2n(a) + l2n(b) == l2n(c);
}

fun main() {

    if (sumofwords("acb", "cba", "cdb")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumofwords("aab", "aac", "ad")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!sumofwords("bc", "je", "jg")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumofwords("a", "aaaa", "aa")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!sumofwords("c", "d", "h")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sumofwords("gfi", "hbf", "bdhd")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
