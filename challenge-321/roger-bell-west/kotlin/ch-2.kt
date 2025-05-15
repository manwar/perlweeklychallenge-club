fun backspacecompare(a: String, b: String): Boolean {
    var sa = ArrayList<String>()
    for (i in listOf(a, b)) {
        var oa = ArrayList<Char>()
        i.toCharArray().forEach() {c ->
            if (c == '#') {
                oa.removeLast()
            } else {
                oa.add(c)
            }
        }
        sa.add(oa.joinToString(""))
    }
    return sa[0] == sa[1]
}

fun main() {

    if (backspacecompare("ab#c", "ad#c")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (backspacecompare("ab##", "a#b#")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!backspacecompare("a#b", "c")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
