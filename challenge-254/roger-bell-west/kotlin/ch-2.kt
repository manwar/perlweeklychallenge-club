fun is_vowel(c: Char): Boolean {
    return when (c.lowercaseChar()) {
        'a', 'e', 'i', 'o', 'u' -> true
        else -> false
    }
}
fun reversevowels(a: String): String {
    val p = a.toCharArray().toList()
    val q = p.filter{is_vowel(it)}
    var qi = q.size
    var o = ArrayList<Char>()
    for (c in p) {
        if (is_vowel(c)) {
            qi -= 1;
            var nc = q[qi]
            if (c.isUpperCase()) {
                nc = nc.uppercaseChar()
            } else {
                nc = nc.lowercaseChar()
            }
            o.add(nc)
        } else {
            o.add(c)
        }
    }
    return o.joinToString("")
}

fun main() {

    if (reversevowels("Raku") == "Ruka") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversevowels("Perl") == "Perl") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversevowels("Julia") == "Jaliu") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversevowels("Uiua") == "Auiu") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
