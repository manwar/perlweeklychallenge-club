fun word2map(word: String): Map<Char, Int> {
    var m = mutableMapOf<Char, Int>()
    for (c in word.lowercase()) {
        if (m.contains(c)) {
            m.set(c, m.get(c)!! + 1)
        } else {
            m.set(c, 1)
        }
    }
    return m
}

fun specialnotes(chars: String, word: String): Boolean {
    val cm = word2map(chars)
    val f = word2map(word)
    var valid = true
    for (c in f.keys) {
        if (!cm.contains(c) ||
            f.get(c)!! > cm.get(c)!!) {
            valid = false
            break
        }
    }
    return valid
}

fun main() {

    if (!specialnotes("abc", "xyz")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialnotes("scriptinglanguage", "perl")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialnotes("aabbcc", "abc")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
