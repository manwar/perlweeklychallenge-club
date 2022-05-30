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

fun cyclicpermute(n: Int): ArrayList<Int> {
    var ss = n.toString()
    var o = ArrayList<Int>()
    for (p in 1..ss.length) {
        ss = ss.slice(1..ss.length-1) + ss.slice(0..0)
        o.add(ss.toInt())
    }
    return o
}

fun circular(mindigits: Int, ct: Int): ArrayList<Int> {
    var o = ArrayList<Int>()
    var base = 1
    for (p in 2..mindigits) {
        base *= 10
    }
    while (o.size < ct) {
        val pr = genprimes(base * 10)
        var prs = pr.toMutableSet()
        for (cp in pr) {
            if (cp >= base) {
                var v = true
                val cpp = cyclicpermute(cp)
                for (cpc in cpp) {
                    if (!prs.contains(cpc)) {
                        v = false
                        break
                    }
                }
                if (v) {
                    o.add(cp)
                    if (o.size >= ct) {
                        break
                    }
                    for (cpc in cpp) {
                        prs.remove(cpc)
                    }
                }
            }
        }
        base *= 10
    }
    return o
}

fun main() {
    if (cyclicpermute(123) == listOf(231, 312, 123)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (circular(3,10) == listOf(113, 197, 199, 337, 1193, 3779,
                                 11939, 19937, 193939, 199933)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
