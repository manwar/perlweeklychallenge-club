fun upperlower(a: String): String {
    var out: String = ""
    a.forEach {c ->
                   out += (c.code xor 32).toChar()
    }
    return out
}

fun main() {

    if (upperlower("pERL") == "Perl") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (upperlower("rakU") == "RAKu") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (upperlower("PyThOn") == "pYtHoN") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
