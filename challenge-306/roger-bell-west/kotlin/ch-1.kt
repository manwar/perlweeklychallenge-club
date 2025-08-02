fun oddsum(a: List<Int>): Int {
    var out = a.sum()
    var l = 3
    while (l <= a.size) {
        for (s in a.windowed(l)) {
            out += s.sum()
        }
        l += 2
    }
    return out
}

fun main() {

    if (oddsum(listOf(2, 5, 3, 6, 4)) == 77) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddsum(listOf(1, 3)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
