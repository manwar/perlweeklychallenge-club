fun findanagrams(a: List<String>): Int {
    var b = ArrayList<String>()
    for (s in a) {
        b.add(s.toList().sorted().joinToString(""))
    }
    var out = 1
    for (s in b.windowed(size = 2)) {
        if (s[0] != s[1]) {
            out += 1
        }
    }
    return out
}

fun main() {

    if (findanagrams(listOf("acca", "dog", "god", "perl", "repl")) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (findanagrams(listOf("abba", "baba", "aabb", "ab", "ab")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
