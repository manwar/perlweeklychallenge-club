import kotlin.collections.*

fun ziplist(a: List<Char>, b: List<Char>): List<Char> {
    var out = ArrayList<Char>()
    for (i in 0..a.size-1) {
        out.add(a[i])
        out.add(b[i])
    }
    return out.toList()
}

fun main() {
    if (ziplist(listOf('1', '2', '3'), listOf('a', 'b', 'c')) ==
            listOf('1', 'a', '2', 'b', '3', 'c')) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
