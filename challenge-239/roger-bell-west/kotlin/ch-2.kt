fun consistentstrings(a: List<String>, v: String): Int {
    val vs = v.toSet()
    return a.filter {s -> s.toCharArray().distinct().all{c -> vs.contains(c)}}.size
}

fun main() {

    if (consistentstrings(listOf("ad", "bd", "aaab", "baa", "badab"), "ab") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (consistentstrings(listOf("a", "b", "c", "ab", "ac", "bc", "abc"), "ab") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (consistentstrings(listOf("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"), "cad") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
