fun reverseprefix(a: String, f: String): String {
    var c = a.toList()
    val fc = f.toList()[0]
    val p = c.indexOf(fc)
    if (p >= 0) {
        val jr = c.slice(0 .. p).asReversed()
        c = jr + c.asReversed().slice(0 .. c.size - p - 2).asReversed()
    }
    return c.joinToString("")
}

fun main() {

    if (reverseprefix("programming", "g") == "gorpramming") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseprefix("hello", "h") == "hello") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseprefix("abcdefghij", "h") == "hgfedcbaij") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseprefix("reverse", "s") == "srevere") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseprefix("perl", "r") == "repl") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
