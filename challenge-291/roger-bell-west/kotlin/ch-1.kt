fun middleindex(a: List<Int>): Int {
    var r = a.sum()
    var l = 0
    a.forEachIndexed{i, c ->
                         r -= c
                     if (r == l) {
                         return i
                     }
                     l += c
    }
    return -1
}

fun main() {

    if (middleindex(listOf(2, 3, -1, 8, 4)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (middleindex(listOf(1, -1, 4)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (middleindex(listOf(2, 5)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
