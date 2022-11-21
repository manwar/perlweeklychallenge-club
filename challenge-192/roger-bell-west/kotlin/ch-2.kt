import kotlin.math.*

fun equaldistribution(list: List<Int>): Int {
    val s = list.sum()
    if (s % list.size != 0) {
        return -1
    }
    val m = s / list.size
    var o: Int = 0
    var w = ArrayList(list)
    while (true) {
        for (i in 0..w.size-2) {
            if (w[i] > m) {
                val v = w[i] - m
                w[i+1] += v
                o += v
                w[i] = m
            } else if (w[i] < m) {
                val v = minOf(m - w[i], w[i+1])
                w[i+1] -= v
                o += v
                w[i] += v
            }
        }
        var done = true
        for (v in w) {
            if (v != m) {
                done = false
                break
            }
        }
        if (done) {
            break
        }
    }
    return o
}

fun main() {
    if (equaldistribution(listOf(1, 0, 5)) == 4) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (equaldistribution(listOf(0, 2, 0)) == -1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (equaldistribution(listOf(0, 3, 0)) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
