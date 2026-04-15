fun groupdivision(a0: String, sz: Int, pad: String): List<String> {
    var a = a0
    while (a.length % sz != 0) {
        a += pad
    }
    var out = ArrayList<String>()
    var i = 0
    while (i < a.length) {
        out.add(a.slice(i .. i + sz - 1))
        i += sz
    }
    return out
}

fun main() {

    if (groupdivision("RakuPerl", 4, "*") == listOf("Raku", "Perl")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (groupdivision("Python", 5, "0") == listOf("Pytho", "n0000")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (groupdivision("12345", 3, "x") == listOf("123", "45x")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (groupdivision("HelloWorld", 3, "_") == listOf("Hel", "loW", "orl", "d__")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (groupdivision("AI", 5, "!") == listOf("AI!!!")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
