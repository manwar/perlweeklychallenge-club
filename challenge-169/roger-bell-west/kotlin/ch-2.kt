import kotlin.math.*

fun gcd(m0: Int,n0: Int): Int {
    var m=m0
    var n=n0
    while (n != 0) {
        val tmp=m % n
        m = n
        n = tmp
    }
    return m
}

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

fun primefactor(n: Int): Map<Int,Int> {
    var f=mutableMapOf<Int,Int>()
    var m=n
    for (p in genprimes(sqrt(m.toDouble()).toInt())) {
        while (m % p == 0) {
            m /= p
            if (f.containsKey(p)) {
                f[p] = f[p]!!+1
            } else {
                f[p]=1
            }
        }
        if (m == 1) {
            break
        }
    }
    if (m > 1) {
        if (f.containsKey(m)) {
            f[m] = f[m]!!+1
        } else {
            f[m]=1
        }
    }
    return f
}

fun achilles(ct: Int): ArrayList<Int> {
    var out = ArrayList<Int>()
    var n = 1
    while (true) {
        n += 1
        val pv = primefactor(n).values
        if (pv.size > 1 &&
            pv.minOrNull()!! >= 2 &&
            pv.reduce { acc, x -> gcd(acc,x) } == 1) {
            out.add(n)
            if (out.size >= ct) {
                break
            }
        }
    }
    return out
}

fun main() {
    if (achilles(20) == listOf(72, 108, 200, 288, 392, 432, 500, 648,
                               675, 800, 864, 968, 972, 1125, 1152,
                               1323, 1352, 1372, 1568, 1800)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
