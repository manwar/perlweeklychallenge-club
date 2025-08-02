fun is_vowel(c: Char): Boolean {
    return when (c.lowercaseChar()) {
        'a', 'e', 'i', 'o', 'u' -> true
        else -> false
    }
}

fun goatlatin(a: String): String {
    var out = ArrayList<String>()
    a.split(" ").forEachIndexed {i, word ->
                                     var c = word.toList()
                                 var nw = StringBuilder(word);
                                 if (!is_vowel(c[0])) {
                                     var co = ArrayList(c.drop(1))
                                     co.add(c[0])
                                     nw = StringBuilder(co.joinToString(""))
                                 }
                                 nw.append("ma")
                                 for (ix in 0..i) {
                                     nw.append("a")
                                 }
                                 out.add(nw.toString())
    }
    return out.joinToString(" ")
}

fun main() {

    if (goatlatin("I love Perl") == "Imaa ovelmaaa erlPmaaaa") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goatlatin("Perl and Raku are friends") == "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goatlatin("The Weekly Challenge") == "heTmaa eeklyWmaaa hallengeCmaaaa") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
