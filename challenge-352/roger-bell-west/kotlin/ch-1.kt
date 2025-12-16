fun matchstring(a: List<String>): List<String> {
    var out = ArrayList<String>()
    for (x in a) {
        if (!out.contains(x)) {
            for (y in a) {
                if (y.length > x.length && y.indexOf(x) >= 0) {
                    out.add(x)
                    break
                }
            }
        }
    }
    return out
}

fun main() {

    if (matchstring(listOf("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")) == listOf("cat", "dog", "dogcat", "rat")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matchstring(listOf("hello", "hell", "world", "wor", "ellow", "elloworld")) == listOf("hell", "world", "wor", "ellow")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matchstring(listOf("a", "aa", "aaa", "aaaa")) == listOf("a", "aa", "aaa")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matchstring(listOf("flower", "flow", "flight", "fl", "fli", "ig", "ght")) == listOf("flow", "fl", "fli", "ig", "ght")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matchstring(listOf("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")) == listOf("car", "pet", "enter", "pen", "pent")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
