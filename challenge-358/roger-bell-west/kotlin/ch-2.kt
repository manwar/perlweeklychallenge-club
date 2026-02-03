fun posmod(x: Int, y: Int): Int {
    var z = x % y
    while (z < 0) {
        z += y
    }
    return z
}

fun rotx(a: Char, offset: Int): Char {
    var o = posmod(offset, 26)
    var base: Int
    if (a >= 'a' && a <= 'z') {
        base = 'a'.code
    } else if (a >= 'A' && a <= 'Z') {
        base = 'A'.code
    } else {
        return a
    }
    var c = posmod(a.code - base + o, 26) + base
    return c.toChar()
}

fun encryptedstring(a: String, offset: Int): String {
    return a.map {rotx(it, offset)}.joinToString("")
}

fun main() {
    if (encryptedstring("abc", 1) == "bcd") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (encryptedstring("xyz", 2) == "zab") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (encryptedstring("abc", 27) == "bcd") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (encryptedstring("hello", 5) == "mjqqt") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (encryptedstring("perl", 26) == "perl") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
