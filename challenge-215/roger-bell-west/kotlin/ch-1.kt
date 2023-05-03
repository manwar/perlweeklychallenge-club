fun oddoneout(a: List<String>): Int {
    var ct = 0
    for (s in a) {
        var p = s.toCharArray()
        p.sort()
        if (p.joinToString("") != s) {
            ct += 1
        }
    }
    return ct
}

fun main() {

    if (oddoneout(listOf("abc", "xyz", "tsu")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddoneout(listOf("rat", "cab", "dad")) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddoneout(listOf("x", "y", "z")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
