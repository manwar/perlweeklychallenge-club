fun sortletters(a: List<Char>, c: List<Int>): String {
    var out = ArrayList<Char>(a)
    a.forEachIndexed{i, l ->
                       out[c[i] - 1] = l
    }
    return out.joinToString("")
}

fun main() {

    if (sortletters(listOf('R', 'E', 'P', 'L'), listOf(3, 2, 1, 4)) == "PERL") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortletters(listOf('A', 'U', 'R', 'K'), listOf(2, 4, 1, 3)) == "RAKU") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortletters(listOf('O', 'H', 'Y', 'N', 'P', 'T'), listOf(5, 4, 2, 6, 1, 3)) == "PYTHON") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
