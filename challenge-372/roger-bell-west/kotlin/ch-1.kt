fun rearrangespaces(a: String): String {
    var words = ArrayList<String>()
    var spaces = 0
    var ww = ""
    for (c in a.toList()) {
        if (c == ' ') {
            spaces += 1
            if (ww != "") {
                words.add(ww)
                ww = ""
            }
        } else {
            ww += c
        }
    }
    if (ww != "") {
        words.add(ww)
    }
    var spdiv = 0
    var remainder = spaces
    var divs = words.size - 1
    if (divs > 0) {
        spdiv = spaces / divs
        remainder = spaces % divs
    }
    var out = words.joinToString(" ".repeat(spdiv))
    if (remainder > 0) {
        out += " ".repeat(remainder)
    }
    return out
}

fun main() {

    if (rearrangespaces("  challenge  ") == "challenge    ") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rearrangespaces("coding  is  fun") == "coding  is  fun") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rearrangespaces("a b c  d") == "a b c d ") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rearrangespaces("  team      pwc  ") == "team          pwc") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (rearrangespaces("   the  weekly  challenge  ") == "the    weekly    challenge ") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
