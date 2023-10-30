fun acronym(strs: List<String>, chk: String): Boolean {
    return strs.map {it.substring(0, 1)}.joinToString("").lowercase() ==
        chk.lowercase()
}

fun main() {

    if (acronym(listOf("Perl", "Python", "Pascal"), "ppp")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!acronym(listOf("Perl", "Raku"), "rp")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (acronym(listOf("Oracle", "Awk", "C"), "oac")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
