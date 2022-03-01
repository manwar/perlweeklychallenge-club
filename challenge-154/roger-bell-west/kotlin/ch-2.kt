fun padovanprime(ct: Int): List<Long> {
    var pp=mutableSetOf<Long>()
    var padovans=mutableListOf(1L,1L,1L)
    while (true) {
        padovans.add(padovans[0]+padovans[1])
        padovans.removeAt(0)
        if (isprime(padovans[2])) {
            pp.add(padovans[2])
            if (pp.size >= ct) {
                break
            }
        }
    }
    return ArrayList(pp).sorted()
}

fun isprime(candidate: Long): Boolean {
    if (candidate==2L) {
        return true
    } else if (candidate==3L) {
        return true
    } else if (candidate % 2 == 0L) {
        return false
    } else if (candidate % 3 == 0L) {
        return false
    }
    var anchor=0
    val limit = Math.sqrt(candidate.toDouble()).toLong()
    while (true) {
        anchor += 6
        for (t in anchor-1..anchor+1 step 2) {
            if (t > limit) {
                return true
            }
            if (candidate % t == 0L) {
                return false
            }
        }
    }
}

fun main() {
    if (padovanprime(10) == listOf(2,3,5,7,37,151,3329,23833,13091204281,3093215881333057)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
