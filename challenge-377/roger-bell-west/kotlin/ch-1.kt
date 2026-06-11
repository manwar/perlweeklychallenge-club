fun reverseexistence(a: String): Boolean {
    val c = a.toList().asReversed();
    for (d in c.windowed(size = 2)) {
        val sample = d[0].toString() + d[1].toString()
        if (a.contains(sample)) {
            return true
        }
    }
    return false
}

fun main() {

    if (reverseexistence("abcba")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseexistence("racecar")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!reverseexistence("abcd")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseexistence("banana")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reverseexistence("hello")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
