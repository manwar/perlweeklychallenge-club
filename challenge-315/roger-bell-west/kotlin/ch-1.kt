fun findwords(a: List<String>, b: String): List<Int> {
    var t = ArrayList<Int>()
    a.forEachIndexed { i, x ->
        if (x.indexOf(b) != -1) {
            t.add(i)
        }
    }
    return t.toList()
}

fun main() {

    if (findwords(listOf("the", "weekly", "challenge"), "e") == listOf(0, 1, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findwords(listOf("perl", "raku", "python"), "p") == listOf(0, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findwords(listOf("abc", "def", "bbb", "bcd"), "b") == listOf(0, 2, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
