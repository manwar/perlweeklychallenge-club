fun sortlanguage(langs: List<String>, popularities: List<Int>): List<String> {
    var ix = ArrayList(generateSequence(0) { it + 1 }.take(langs.size).toList())
    ix.sortBy { popularities[it] }
    return ix.map {n -> langs[n]}
}

fun main() {

    if (sortlanguage(listOf("perl", "c", "python"), listOf(2, 1, 3)) == listOf("c", "perl", "python")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortlanguage(listOf("c++", "haskell", "java"), listOf(1, 3, 2)) == listOf("c++", "java", "haskell")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
