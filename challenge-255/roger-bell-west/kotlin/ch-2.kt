import kotlin.math.max

fun mostfrequentword(para: String, banned: String): String {
    var words = mutableMapOf<String, Int>().withDefault({0})
    for (w in para.split("[^A-Za-z]+".toRegex())
             .filter{it.length > 0}) {
        words.set(w, words.getValue(w) + 1)
    }
    words.remove(banned)
    val m = words.values.maxOrNull()!!
    val l = words.keys.filter{words[it] == m}.toList()
    return l[0]
}

fun main() {

    if (mostfrequentword("Joe hit a ball, the hit ball flew far after it was hit.", "hit") == "ball") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mostfrequentword("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the") == "Perl") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
