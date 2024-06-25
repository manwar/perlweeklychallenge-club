fun replacedigits(a: String): String {
    var out = ""
    var prev = 0
    for (c in a.toList()) {
        if (c >= '0' && c <= '9') {
            out += (prev + c.digitToInt()).toChar()
        } else {
            prev = c.code
            out += c
        }
    }
    return out
}

fun main() {

    if (replacedigits("a1c1e1") == "abcdef") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacedigits("a1b2c3d4") == "abbdcfdh") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacedigits("b2b") == "bdb") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (replacedigits("a16z") == "abgz") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
