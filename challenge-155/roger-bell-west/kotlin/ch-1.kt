import kotlin.math.*

fun genprimes(mx: Int): ArrayList<Int> {
    var primesh=mutableSetOf<Int>()
    for (i in 2..3) {
        primesh.add(i)
    }
    for (i in 6..mx+1 step 6) {
        for (j in i-1..i+1 step 2) {
            if (j <= mx) {
                primesh.add(j)
            }
        }
    }
    var q=ArrayDeque(listOf(2,3,5,7))
    var p=q.removeFirst()
    val mr=sqrt(mx.toDouble()).toInt()
    while (p <= mr) {
        if (primesh.contains(p)) {
            for (i in p*p..mx step p) {
                primesh.remove(i)
            }
        }
        if (q.size < 2) {
            q.add(q.last()+4)
            q.add(q.last()+2)
        }
        p=q.removeFirst()
    }
    var primes=ArrayList(primesh.distinct())
    primes.sort()
    return primes
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

fun nthprimelimit(n: Int): Int {
    var m=15
    if (n >= 6) {
        val nn=n.toDouble()
        m=1+(nn*ln(nn*ln(nn))).toInt()
    }
    return m
}

fun fortunate(ct: Int): ArrayList<Int> {
    val n=ct*2
    var o=mutableSetOf<Int>()
    var ll=ArrayList<Int>()
    var ph=1L
    for (p in genprimes(nthprimelimit(n))) {
        ph *= p.toLong()
        if (o.size >= ct) {
            if (p >= o.toList().maxOrNull()!!) {
                break
            }
        }
        var l=p+1
        while (!isprime(l+ph)) {
            l += 1
        }
        o.add(l)
        if (o.size > ct) {
            ll=ArrayList(o.distinct())
            ll.sort()
            if (ll.size > ct) {
                ll=ArrayList(ll.dropLast(ll.size-ct))
            }
            o=ll.toMutableSet()
        }
    }
    return ll
}

fun main() {
    if (fortunate(8) == listOf(3, 5, 7, 13, 17, 19, 23, 37)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
