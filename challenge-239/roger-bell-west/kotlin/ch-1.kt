fun samestring(a: List<String>, b: List<String>): Boolean {
    return a.joinToString("") == b.joinToString("")
}

fun main() {

    if (samestring(listOf("ab", "c"), listOf("a", "bc"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!samestring(listOf("ab", "c"), listOf("ac", "b"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (samestring(listOf("ab", "cd", "e"), listOf("abcde"))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
