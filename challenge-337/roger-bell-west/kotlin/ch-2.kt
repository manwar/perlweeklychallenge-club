fun oddmatrix(rows: Int, cols: Int, points: List<List<Int>>): Int {
    var rm = mutableSetOf<Int>()
    var cm = mutableSetOf<Int>()
    for (p in points) {
        if (rm.contains(p[0])) {
            rm.remove(p[0])
        } else {
            rm.add(p[0])
        }
        if (cm.contains(p[1])) {
            cm.remove(p[1])
        } else {
            cm.add(p[1])
        }
    }
    return rm.size * (cols - cm.size) + cm.size * (rows - rm.size)
}

fun main() {

    if (oddmatrix(2, 3, listOf(listOf(0, 1), listOf(1, 1))) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddmatrix(2, 2, listOf(listOf(1, 1), listOf(0, 0))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddmatrix(3, 3, listOf(listOf(0, 0), listOf(1, 2), listOf(2, 1))) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddmatrix(1, 5, listOf(listOf(0, 2), listOf(0, 4))) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (oddmatrix(4, 2, listOf(listOf(1, 0), listOf(3, 1), listOf(2, 0), listOf(0, 1))) == 8) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
