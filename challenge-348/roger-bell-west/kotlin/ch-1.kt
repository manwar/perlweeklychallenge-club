fun is_vowel(c: Char): Boolean {
    return when (c.lowercaseChar()) {
        'a', 'e', 'i', 'o', 'u' -> true
        else -> false
    }
}

fun stringalike(a: String): Boolean {
    if (a.length % 2 == 1) {
        return false
    }
    var vt = 0
    var mode = 1
    var av = false
    a.toList().forEachIndexed { i, c ->
                                  if (i * 2 == a.length) {
                                      mode = -1
                                  }
                              if (is_vowel(c)) {
                                  av = true
                                  vt += mode
                              }
    }
    return av && (vt == 0)
}

fun main() {

    if (!stringalike("textbook")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringalike("book")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stringalike("AbCdEfGh")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!stringalike("rhythmmyth")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!stringalike("UmpireeAudio")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
