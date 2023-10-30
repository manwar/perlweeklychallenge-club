fun removeone(a: List<Int>): Boolean {
    var ec = 0
    var le = 1 + a[1] - a[0]
    for (s in a.windowed(size = 2)) {
        if (s[1] <= s[0]) {
            ec += 1
            if (ec > 1 || s[0] - s[1] >= le) {
                return false
            }
        }
        le = s[1] - s[0]
    }
    return true
}

fun main() {

    if (removeone(listOf(0, 2, 9, 4, 6))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!removeone(listOf(5, 1, 3, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (removeone(listOf(2, 2, 3))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
