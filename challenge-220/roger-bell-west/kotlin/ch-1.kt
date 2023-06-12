fun word2set(word: String): MutableSet<Char> {
    var r = mutableSetOf<Char>()
    for (c in word.lowercase()) {
        if (c >= 'a' && c <= 'z') {
            r.add(c)
        }
    }
    return r
}

fun commoncharacters(lst: List<String>): List<Char> {
    var c = word2set(lst[0])
    for (w in lst.drop(1)) {
        c = c.intersect(word2set(w)).toMutableSet()
    }
    var s = ArrayList(c)
    s.sort()
    return s.toList()
}

fun main() {

    if (commoncharacters(listOf("Perl", "Rust", "Raku")) == listOf('r')) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (commoncharacters(listOf("love", "live", "leave")) == listOf('e', 'l', 'v')) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
