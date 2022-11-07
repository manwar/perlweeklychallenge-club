fun capitaldetection(s: String): Boolean {
    val re = "^([A-Z]+|[a-z]+|[A-Z][a-z]+)$".toRegex()
    return re.containsMatchIn(s)
}

fun main() {
    if (capitaldetection("Perl")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (capitaldetection("TPF")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (!capitaldetection("PyThon")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (capitaldetection("raku")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
