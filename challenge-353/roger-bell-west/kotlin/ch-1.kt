fun maxwords(a: List<String>): Int {
    return a.map { it.split(" ").size }.maxOrNull()!!
}

fun main() {

    if (maxwords(listOf("Hello world", "This is a test", "Perl is great")) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxwords(listOf("Single")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxwords(listOf("Short", "This sentence has six words in total", "A B C", "Just four words here")) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxwords(listOf("One", "Two parts", "Three part phrase", "")) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maxwords(listOf("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question")) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
