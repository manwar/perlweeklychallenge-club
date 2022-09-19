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

fun ppc(ct: Int): List<Int> {
    var o = ArrayList<Int>()
    var fh = 0
    while (o.size < ct) {
        fh += 1
        var t = fh
        var q = false
        while (t > 0) {
            if (t % 10 == 0) {
                q = true
                break
            }
            t /= 10
        }
        if (q) {
            continue
        }
        val sfh = fh.toString()
        val c = (sfh + "0" + sfh.reversed()).toInt()
        if (isprime(c.toLong())) {
            o.add(c)
        }
    }
    return o
}

fun main() {
    if (ppc(20) == listOf(101, 16061, 31013, 35053, 38083, 73037,
                          74047, 91019, 94049, 1120211, 1150511,
                          1160611, 1180811, 1190911, 1250521, 1280821,
                          1360631, 1390931, 1490941, 1520251)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
