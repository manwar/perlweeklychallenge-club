fun acronyms(a: List<String>, b: String): Boolean {
    var os = ""
    for (c in a) {
        os += c.first()
    }
    return os == b
}

fun main() {

    if (acronyms(listOf("Perl", "Weekly", "Challenge"), "PWC")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (acronyms(listOf("Bob", "Charlie", "Joe"), "BCJ")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!acronyms(listOf("Morning", "Good"), "MM")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
