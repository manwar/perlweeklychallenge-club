import kotlin.math.max

fun mergestrings(a: String, b: String): String {
    var out = ""
    for (i in 0 .. listOf(a.length, b.length).maxOrNull()!! - 1) {
        if (i <= a.length - 1) {
            out += a.substring(i, i+1)
        }
        if (i <= b.length - 1) {
            out += b.substring(i, i+1)
        }
    }
    return out
}

fun main() {

    if (mergestrings("abcd", "1234") == "a1b2c3d4") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mergestrings("abc", "12345") == "a1b2c345") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mergestrings("abcde", "123") == "a1b2c3de") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
