fun countevendigitsnumber(a: List<Int>): Int {
    var t = 0
    for (p in a) {
        var even = false
        var pt = p
        while (pt >= 10) {
            pt /= 10
            even = !even
        }
        if (even) {
            t += 1
        }
    }
    return t
}

fun main() {

    if (countevendigitsnumber(listOf(10, 1, 111, 24, 1000)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countevendigitsnumber(listOf(111, 1, 11111)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countevendigitsnumber(listOf(2, 8, 1024, 256)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
