fun oddcharacter(s: String, t: String): Char {
    var ss = mutableMapOf<Char, Int>().withDefault({0})
    for (c in s.toCharArray()) {
        ss.set(c, ss.getValue(c) + 1)
    }
    for (c in t.toCharArray()) {
        if (ss.getValue(c) > 0) {
            ss.set(c, ss.getValue(c) - 1)
        } else {
            return c
        }
    }
    return '@'
}

fun main() {

    if (oddcharacter("Perl", "Preel") == 'e') {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddcharacter("Weekly", "Weeakly") == 'a') {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddcharacter("Box", "Boxy") == 'y') {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
