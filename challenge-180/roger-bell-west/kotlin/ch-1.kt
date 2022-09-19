fun firstunique(s: String): Int {
    var cc = mutableMapOf<Char,Int>()
    for (c in s.toCharArray()) {
        if (cc.containsKey(c)) {
            cc[c] = cc[c]!! + 1
        } else {
            cc[c] = 1
        }
    }
    for ((i,c) in s.toCharArray().withIndex()) {
        if (cc[c] == 1) {
            return i
        }
    }
    return -1
}

fun main() {
    if (firstunique("Perl Weekly Challenge") == 0) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (firstunique("Long Live Perl") == 1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (firstunique("aabbcc") == -1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
