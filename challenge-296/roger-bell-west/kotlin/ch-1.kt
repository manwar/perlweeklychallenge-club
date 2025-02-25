fun compressedunit(count: Int, letter: Char): String {
    var out = ""
    if (count > 1) {
        out += count.toString()
    }
    out += letter
    return out
}
fun stringcompression(a: String): String {
    var out: String = ""
    var lastchar = '@'
    var count = 0
    for (c in a.toList()) {
        if (count == 0 || c != lastchar) {
            if (count > 0) {
                out += compressedunit(count, lastchar);
            }
            lastchar = c
            count = 0
        }
        count += 1;
    }
    if (count > 0) {
        out += compressedunit(count, lastchar);
    }
    return out
}
fun stringdecompression(a: String): String {
    var out = ""
    var count = 0
    for (c in a.toList()) {
        if (c >= '0' && c <= '9') {
            count *= 10
            count += c.digitToInt()
        } else {
            if (count == 0) {
                count = 1
            }
            out += c.toString().repeat(count)
            count = 0
        }
    }
    return out
}

fun main() {

    if (stringcompression("abbc") == "a2bc") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringcompression("aaabccc") == "3ab3c") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringcompression("abcc") == "ab2c") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringdecompression("a2bc") == "abbc") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringdecompression("3ab3c") == "aaabccc") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringdecompression("ab2c") == "abcc") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
