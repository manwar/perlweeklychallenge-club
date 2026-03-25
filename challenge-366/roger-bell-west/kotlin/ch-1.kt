fun countprefixes(a: List<String>, b: String): Int {
    return a.filter{b.startsWith(it)}.size
}

fun main() {

    if (countprefixes(listOf("a", "ap", "app", "apple", "banana"), "apple") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countprefixes(listOf("cat", "dog", "fish"), "bird") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countprefixes(listOf("hello", "he", "hell", "heaven", "he"), "hello") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countprefixes(listOf("", "code", "coding", "cod"), "coding") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countprefixes(listOf("p", "pr", "pro", "prog", "progr", "progra", "program"), "program") == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
