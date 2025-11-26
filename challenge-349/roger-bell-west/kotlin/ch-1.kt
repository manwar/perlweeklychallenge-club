fun powerstring(a: String): Int {
    var mx = 0
    var prev = 'A'
    var cur = 0
    for (c in a.toList()) {
        if (cur > 0 && c == prev) {
            cur += 1
        } else {
            cur = 1
            prev = c
        }
        mx = listOf(mx, cur).maxOrNull()!!
    }
    return mx
}

fun main() {

    if (powerstring("textbook") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (powerstring("aaaaa") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (powerstring("hoorayyy") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (powerstring("x") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (powerstring("aabcccddeeffffghijjk") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
