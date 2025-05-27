fun incrementdecrement(operations: List<String>): Int {
    var p = 0
    for (s in operations) {
        if (s.get(1) == '+') {
            p += 1
        } else {
            p -= 1
        }
    }
    return p
}

fun main() {

    if (incrementdecrement(listOf("--x", "x++", "x++")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (incrementdecrement(listOf("x++", "++x", "x++")) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (incrementdecrement(listOf("x++", "++x", "--x", "x--")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
