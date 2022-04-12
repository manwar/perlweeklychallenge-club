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

fun moebius(n: Int): Int {
    var z: Int=0
    for (v in primefactor(n).values) {
        if (v > 1) {
            return 0
        }
        z += 1
    }
    if (z % 2 == 0) {
        return 1
    }
    return -1
}

fun main() {
    if (moebius(5) == -1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (moebius(10) == 1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (moebius(20) == 0) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
