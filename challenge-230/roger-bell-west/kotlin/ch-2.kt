fun prefixwords(s: List<String>, p: String): Int {
    return s.filter {it.startsWith(p)}.size
}

fun main() {

    if (prefixwords(listOf("pay", "attention", "practice", "attend"), "at") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (prefixwords(listOf("janet", "julia", "java", "javascript"), "ja") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
