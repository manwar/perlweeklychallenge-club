fun brokenkeys(a: String, k: List<Char>): Int {
    var out = 0
    val failset: Set<Char> = k.map{it.lowercaseChar()}.toSet()
    for (word in a.split(" ")) {
        val wordset: Set<Char> = word.lowercase().toSet()
        if (failset.intersect(wordset).isEmpty()) {
            out += 1
        }
    }
    return out
}

fun main() {

    if (brokenkeys("Perl Weekly Challenge", listOf('l', 'a')) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeys("Perl and Raku", listOf('a')) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeys("Well done Team PWC", listOf('l', 'o')) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
