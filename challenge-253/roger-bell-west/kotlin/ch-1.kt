fun splitstrings(a: List<String>, sep: String): List<String> {
    var p = ArrayList<String>()
    for (s in a) {
        p.addAll(s.split(sep).filter{it.length > 0})
        }
    return p.toList()
}

fun main() {

    if (splitstrings(listOf("one.two.three", "four.five", "six"), ".") == listOf("one", "two", "three", "four", "five", "six")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (splitstrings(listOf("\$perl\$\$", "\$\$raku\$"), "\$") == listOf("perl", "raku")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
