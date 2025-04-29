fun wordcount(a: List<String>): Int {
    var ct = 0
    for (w in a) {
        ct += when(w.first()) {
            'a', 'e', 'i', 'o', 'u' -> 1
            else -> {
                when(w.last()) {
                    'a', 'e', 'i', 'o', 'u' -> 1
                    else -> 0
                }
            }
        }
    }
    return ct
}

fun main() {

    if (wordcount(listOf("unicode", "xml", "raku", "perl")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordcount(listOf("the", "weekly", "challenge")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (wordcount(listOf("perl", "python", "postgres")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
