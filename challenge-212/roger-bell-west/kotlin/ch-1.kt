fun jumpingletters(word: String, jump: List<Int>): String {
    var s = ArrayList<Char>()
    for ((i, c) in word.asSequence().withIndex()) {
        var d = c + jump[i] % 26
        if ((c <= 'Z' && d > 'Z') || d > 'z') {
            d -= 26;
        }
        s.add(d)
    }
    return s.joinToString(separator = "")
}

fun main() {

    if (jumpingletters("Perl", listOf(2, 22, 19, 9)) == "Raku") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (jumpingletters("Raku", listOf(24, 4, 7, 17)) == "Perl") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
