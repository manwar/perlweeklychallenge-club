fun h_index(c0: List<Int>): Int {
    var c = ArrayList(c0)
    c.sort()
    c.reverse()
    var h = 0
    for ((i, x) in c.withIndex()) {
        if (i + 1 <= x) {
            h = i + 1
        } else {
            break
        }
    }
    return h
}

fun main() {

    if (h_index(listOf(10, 8, 5, 4, 3)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (h_index(listOf(25, 8, 5, 3, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
