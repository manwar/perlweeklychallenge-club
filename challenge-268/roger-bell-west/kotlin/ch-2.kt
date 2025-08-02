fun numbergame(a0: List<Int>): List<Int> {
    var out = ArrayList<Int>()
    val a = a0.sorted()
    for (s in a.chunked(2)) {
        out.add(s[1])
        out.add(s[0])
    }
    return out.toList()
}

fun main() {

    if (numbergame(listOf(2, 5, 3, 4)) == listOf(3, 2, 5, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (numbergame(listOf(9, 4, 1, 3, 6, 4, 6, 1)) == listOf(1, 1, 4, 3, 6, 4, 9, 6)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (numbergame(listOf(1, 2, 2, 3)) == listOf(2, 1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
