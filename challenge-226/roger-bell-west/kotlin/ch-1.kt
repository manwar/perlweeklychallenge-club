fun shufflestring(st: String, mp: List<Int>): String {
    var r = Array(st.length) { ' ' }
    for (i in 0 .. mp.size - 1) {
        r[mp[i]] = st[i]
    }
    return r.joinToString("")
}

fun main() {

    if (shufflestring("lacelengh", listOf(3, 2, 0, 5, 4, 8, 6, 7, 1)) == "challenge") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (shufflestring("rulepark", listOf(4, 7, 3, 1, 0, 5, 2, 6)) == "perlraku") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
