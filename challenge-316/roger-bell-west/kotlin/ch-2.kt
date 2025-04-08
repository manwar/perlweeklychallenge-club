fun subsequence(a: String, b: String): Boolean {
    var l = a
    var s = b
    if (a.length < b.length) {
        l = b
        s = a
    }
    val st = s.toCharArray()
    var si = 0
    for (c in l.toCharArray()) {
        if (c == st[si]) {
            si += 1
            if (si >= st.size) {
                return true
            }
        }
    }
    return false
}

fun main() {

    if (subsequence("uvw", "bcudvew")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!subsequence("aec", "abcde")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (subsequence("sip", "javascript")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
