fun frequencyequalizer(s: String): Boolean {
    var f = mutableMapOf<Char, Int>()
    for (c in s) {
        var l = f.getOrDefault(c, 0);
        f.set(c, l + 1);
    }
    val v = f.values.sorted()
    if (v[0] == v[v.size - 2] &&
        v[0] + 1 == v[v.size - 1]) {
        return true
    }
    return false
}

fun main() {
    if (frequencyequalizer("abbc")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (frequencyequalizer("xyzyyxz")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (!frequencyequalizer("xzxz")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
