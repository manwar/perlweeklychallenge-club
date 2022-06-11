import kotlin.math.*

fun isprime(candidate: Int): Boolean {
    if (candidate < 2) {
        return false
    } else if (candidate==2) {
        return true
    } else if (candidate==3) {
        return true
    } else if (candidate % 2 == 0) {
        return false
    } else if (candidate % 3 == 0) {
        return false
    }
    var anchor=0
    val limit = Math.sqrt(candidate.toDouble()).toInt()
    while (true) {
        anchor += 6
        for (t in anchor-1..anchor+1 step 2) {
            if (t > limit) {
                return true
            }
            if (candidate % t == 0) {
                return false
            }
        }
    }
}

fun nthprimelimit(n: Int): Int {
    var m=15
    if (n >= 6) {
        val nn=n.toDouble()
        m=1+(nn*ln(nn*ln(nn))).toInt()
    }
    return m
}

fun pernicious(n: Int): ArrayList<Int> {
    var out=ArrayList<Int>()
    var c=1
    while (true) {
        if (isprime(c.countOneBits())) {
            out.add(c)
            if (out.size >= n) {
                break
            }
        }
        c += 1
    }
    return out
}

fun main() {
    if (pernicious(10) == listOf(3, 5, 6, 7, 9, 10, 11, 12, 13, 14)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
