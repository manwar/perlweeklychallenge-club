fun consecutivesequence(a: List<Int>): Int {
    val b = a.sorted()
    var mxlen = 0
    var here = 0
    while (true) {
        for (there in here + 1 .. b.size - 1) {
            if (b[there] != there - here + b[here]) {
                val l = there - here
                if (l > mxlen) {
                    mxlen = l
                }
                here = there
                break
            }
            if (there == b.size - 1) {
                val l = there - here + 1
                if (l > mxlen) {
                    mxlen = l
                }
                here = there
                break
            }
        }
        if (here >= b.size - 1) {
            break
        }
    }
    if (mxlen < 2) {
        mxlen = -1
    }
    return mxlen
}

fun main() {

    if (consecutivesequence(listOf(10, 4, 20, 1, 3, 2)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (consecutivesequence(listOf(0, 6, 1, 8, 5, 2, 4, 3, 0, 7)) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (consecutivesequence(listOf(10, 30, 20)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
