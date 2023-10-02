fun lexicographic(a: List<String>): Int {
    var t = 0
    for (st in a) {
        var q = st.toCharArray()
        q.sort()
        if (q.joinToString("") == st) {
            continue
        }
        q.reverse()
        if (q.joinToString("") == st) {
            continue
        }
        t += 1
    }
    return t
}

fun main() {

    if (lexicographic(listOf("abc", "bce", "cae")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (lexicographic(listOf("yxz", "cba", "mon")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
