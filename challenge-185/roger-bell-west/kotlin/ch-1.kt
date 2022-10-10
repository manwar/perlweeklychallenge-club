fun recomposemac(inp: String): String {
    var out = ""
    var count = 0
    for (c in inp) {
        if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f')) {
            if (count == 2) {
                out += ":"
                count = 0
            }
            count += 1
            out += c
        }
    }
    return out
}

fun main() {
    if (recomposemac("1ac2.34f0.b1c2") ==
            "1a:c2:34:f0:b1:c2") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (recomposemac("abc1.20f1.345a") ==
            "ab:c1:20:f1:34:5a") {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
