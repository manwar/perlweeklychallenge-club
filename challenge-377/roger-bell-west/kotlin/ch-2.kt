fun prefixsuffix(a0: List<String>): Int {
    var tot = 0
    val a = a0.sortedWith(compareBy { it.length} )
    for (si in 0 .. (a.size - 2)) {
        for (li in (si + 1) .. (a.size - 1)) {
            if (a[li].startsWith(a[si]) && a[li].endsWith(a[si])) {
                tot += 1
            }
        }
    }
    return tot
}

fun main() {

    if (prefixsuffix(listOf("a", "aba", "ababa", "aa")) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (prefixsuffix(listOf("pa", "papa", "ma", "mama")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (prefixsuffix(listOf("abao", "abab")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (prefixsuffix(listOf("abab", "abab")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (prefixsuffix(listOf("ab", "abab", "ababab")) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
