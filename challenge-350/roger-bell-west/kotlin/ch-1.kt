fun counterify(a: List<Char>): Map<Char, Int> {
    var cc = mutableMapOf<Char, Int>().withDefault({0})
    for (x in a) {
        cc.set(x, cc.getValue(x) + 1)
    }
    return cc
}

fun goodsubstrings(a: String): Int {
    var p = 0
    for (s in a.toList().windowed(size = 3)) {
        val c = counterify(s)
        if (c.values.maxOrNull()!! == 1) {
            p++
        }
    }
    return p
}

fun main() {

    if (goodsubstrings("abcaefg") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodsubstrings("xyzzabc") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodsubstrings("aababc") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodsubstrings("qwerty") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodsubstrings("zzzaaa") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
