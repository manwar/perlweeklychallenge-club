fun matchingmembers(a: List<Int>): Int {
    var b = ArrayList(a)
    b.sort()
    var o = 0
    for (i in 0 .. a.size-1) {
        if (a[i] == b[i]) {
            o += 1
        }
    }
    return o
}

fun main() {

    if (matchingmembers(listOf(1, 1, 4, 2, 1, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matchingmembers(listOf(5, 1, 2, 3, 4)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matchingmembers(listOf(1, 2, 3, 4, 5)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
