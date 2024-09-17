fun validnumber(a: String): Boolean {
    val integer = "[-+]?[0-9]+"
    val float = """[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)"""
    val exponential =
        "(" + integer + "|" + float + ")[Ee]" + integer
    val number =
        "^(" + integer + "|" + float + "|" + exponential + ")$" 
    val rx = number.toRegex()
    return rx.containsMatchIn(a)
}

fun main() {

    if (validnumber("1")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!validnumber("a")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!validnumber(".")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!validnumber("1.2e4.2")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validnumber("-1.")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validnumber("+1E-8")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validnumber(".44")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
