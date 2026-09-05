import kotlin.math.min
import kotlin.math.max

fun zigzagsubarray(a: List<Int>): Int {
    var mx = min(1, a.size)
    for (i in 0 .. a.size - 1) {
        var o = 0
        var lastdir = 0
        for (j in i .. a.size - 1) {
            var thisdir = 0
            if (j > i) {
                if (a[j] > o) {
                    thisdir = 1
                    mx = max(mx, 2)
                } else if (a[j] < o) {
                    thisdir = -1
                    mx = max(mx, 2)
                }
            }
            if ((j > i && thisdir == 0) || (j > i + 1 && thisdir * lastdir != -1)) {
                break
            }
            o = a[j]
            lastdir = thisdir
            mx = max(mx, j - i + 1)
        }
    }
    return mx
}

fun main() {

    if (zigzagsubarray(listOf(9, 4, 2, 10, 7, 8, 8, 1, 9)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zigzagsubarray(listOf(1, 7, 4, 9, 2, 5)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zigzagsubarray(listOf(1, 2, 3, 4, 5)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zigzagsubarray(listOf(4, 4, 4)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zigzagsubarray(listOf(10, 20, 15, 12, 18)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
