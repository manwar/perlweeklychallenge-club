import kotlin.math.min

fun equalstrings(a: List<String>): Int {
    val ax = a.toSet()
    var ca = ArrayList<List<Char>>();
    for (x in ax) {
        ca.add(x.toList())
    }
    val mmlen = ca.map { it.size }.minOrNull()!!
    var si = 0
    for (i in 0 .. mmlen - 1) {
        si = i
        for (s in 1 .. ca.size - 1) {
            if (ca[0][i] != ca[s][i]) {
                if (i == 0) {
                    return -1
                }
                si -= 1
                break
            }
        }
    }
    return a.map { it.length }.sum() - a.size * (si + 1)
}

fun main() {

    if (equalstrings(listOf("abc", "abb", "ab")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (equalstrings(listOf("ayz", "cyz", "xyz")) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (equalstrings(listOf("yza", "yzb", "yzc")) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
