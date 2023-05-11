fun word2set(word: String): MutableSet<Char> {
    var r = mutableSetOf<Char>()
    for (c in word.lowercase()) {
        if (c >= 'a' && c <= 'z') {
            r.add(c)
        }
    }
    return r
}

fun registrationnumber(words: List<String>, reg: String): List<String> {
    var out = ArrayList<String>()
    for (w in words) {
        var ss = word2set(reg);
        for (char in word2set(w)) {
            if (ss.contains(char)) {
                ss.remove(char);
                if (ss.size == 0) {
                    out.add(w)
                    break
                }
            }
        }
    }
    return out
}

fun main() {

    if (registrationnumber(listOf("abc", "abcd", "bcd"), "AB1 2CD") == listOf("abcd")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (registrationnumber(listOf("job", "james", "bjorg"), "007 JB") == listOf("job", "bjorg")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (registrationnumber(listOf("crack", "road", "rac"), "C7 RA2") == listOf("crack", "rac")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
