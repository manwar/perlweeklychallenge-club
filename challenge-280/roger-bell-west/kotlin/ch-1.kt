fun twiceappearance(a: String): Char {
    var m = mutableSetOf<Char>()
    for (c in a.toList()) {
        if (m.contains(c)) {
            return c
        } else {
            m.add(c)
        }
    }
    return 'x'
}

fun main() {

    if (twiceappearance("acbddbca") == 'd') {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (twiceappearance("abccd") == 'c') {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (twiceappearance("abcdabbb") == 'a') {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
