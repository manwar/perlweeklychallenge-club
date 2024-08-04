fun countasterisks(a: String): Int {
    var out = 0
    var active = true
    for (c in a.toList()) {
        when(c) {
            '|' -> { active = !active }
            '*' -> {
                if (active) {
                    out += 1
                }
            }
        }
    }
    return out
}

fun main() {

    if (countasterisks("p|*e*rl|w**e|*ekly|") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countasterisks("perl") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countasterisks("th|ewe|e**|k|l***ych|alleng|e") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
