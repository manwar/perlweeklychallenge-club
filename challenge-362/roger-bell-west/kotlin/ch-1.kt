fun echochamber(a: String): String {
    var out = ""
    for ((i, c) in a.asSequence().withIndex() ) {
        out += c.toString().repeat(i + 1)
    }
    return out
}

fun main() {

    if (echochamber("abca") == "abbcccaaaa") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (echochamber("xyz") == "xyyzzz") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (echochamber("code") == "coodddeeee") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (echochamber("hello") == "heelllllllooooo") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (echochamber("a") == "a") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
