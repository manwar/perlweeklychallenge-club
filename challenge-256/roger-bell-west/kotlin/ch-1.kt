fun maximumpairs(a: List<String>): Int {
    var n = 0
    var r = mutableSetOf<String>()
    for (s in a) {
        val t = s.reversed()
        if (r.contains(t)) {
            n += 1
        } else {
            r.add(s)
        }
    }
    return n
}

fun main() {

    if (maximumpairs(listOf("ab", "de", "ed", "bc")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumpairs(listOf("aa", "ba", "cd", "ed")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumpairs(listOf("uv", "qp", "st", "vu", "mn", "pq")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
