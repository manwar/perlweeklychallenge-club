import kotlin.math.*

fun isprime(candidate: Long): Boolean {
    if (candidate < 2L) {
        return false
    } else if (candidate==2L) {
        return true
    } else if (candidate==3L) {
        return true
    } else if (candidate % 2L == 0L) {
        return false
    } else if (candidate % 3L == 0L) {
        return false
    }
    var anchor=0L
    val limit = Math.sqrt(candidate.toDouble()).toLong()
    while (true) {
        anchor += 6L
        for (t in anchor-1L..anchor+1L step 2L) {
            if (t > limit) {
                return true
            }
            if (candidate % t == 0L) {
                return false
            }
        }
    }
}

fun perrinprime(n: Long): ArrayList<Long> {
    var ot = mutableSetOf<Long>()
    var seq = mutableListOf(3L, 0L, 2L)
    while (true) {
        val nv = seq[0] + seq[1]
        seq.removeAt(0)
        seq.add(nv)
        if (isprime(nv)) {
            ot.add(nv)
            if (ot.size >= n) {
                break;
            }
        }
    }
    var o = ArrayList(ot)
    o.sort()
    return o
}

fun main() {
    if (perrinprime(13) == listOf(2, 3, 5, 7, 17, 29, 277, 367, 853,
                                  14197, 43721, 1442968193,
                                  792606555396977)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
