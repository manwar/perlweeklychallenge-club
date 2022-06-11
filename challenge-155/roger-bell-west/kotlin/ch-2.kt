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
    for (p in listOf(2,3,5,7)) {
        while (m % p == 0) {
            m /= p
            if (f.containsKey(p)) {
                f[p] = f[p]!!+1
            } else {
                f[p]=1
            }
        }
    }
    if (m > 1) {
        for (p in genprimes(m)) {
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
    }
    return f
}

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

fun lcm(m: Int,n: Int): Int {
    return m/gcd(m,n)*n
}

fun intPow(x0: Int,pow0: Int): Int {
    var x=x0
    var pow=pow0
    var ret=1
    while (pow > 0) {
        if ( (pow and 1) == 1 ) {
            ret *= x
        }
        x *= x
        pow = pow shr 1
    }
    return ret
}

fun pisano(n: Int): Int {
    var a=1
    for ((k,v) in primefactor(n).entries) {
        val nn=intPow(k,v)
        var t=1
        var x=listOf(1,1)
        while (x != listOf(0,1)) {
            t += 1
            x=listOf(x[1], (x[0]+x[1]) % nn )
        }
        a=lcm(a,t)
    }
    return a
}

fun main() {
    if (pisano(3) == 8) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (pisano(6) == 24) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
