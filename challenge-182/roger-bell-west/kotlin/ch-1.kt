fun maxindex(n: List<Int>): Int {
    var mxv = 0;
    var mxi = 0;
    for ((i, v) in n.withIndex()) {
        if (i == 0 || v > mxv) {
            mxv = v
            mxi = i
        }
    }
    return mxi
}

fun main() {
    if (maxindex(listOf(5, 2, 9, 1, 7, 6)) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (maxindex(listOf(4, 2, 3, 1, 5, 0)) == 4) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (maxindex(listOf(4, 2, 3, 1, 4, 0)) == 0) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
