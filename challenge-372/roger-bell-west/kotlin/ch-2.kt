fun largestsubstring(a: String): Int {
    var cc = a.toList()
    for (offset in cc.size - 1 downTo 1) {
        for (x in 0 .. cc.size - offset - 1) {
            if (cc[x] == cc[x + offset]) {
                return offset - 1
            }
        }
    }
    return -1
}

fun main() {

    if (largestsubstring("aaaaa") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (largestsubstring("abcdeba") == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (largestsubstring("abbc") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (largestsubstring("abcaacbc") == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (largestsubstring("laptop") == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
