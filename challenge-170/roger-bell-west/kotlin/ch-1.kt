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

fun nthprimelimit(n: Int): Int {
    var m=15
    if (n >= 6) {
        val nn=n.toDouble()
        m=1+(nn*ln(nn*ln(nn))).toInt()
    }
    return m
}

fun primorial(ct: Int): MutableList<Int> {
    var o = mutableListOf(1)
    for (p in genprimes(nthprimelimit(ct-1))) {
        o.add(o.lastOrNull()!! * p)
        if (o.size >= ct) {
            break
        }
    }
    return o
}

fun main() {
    if (primorial(5) == listOf(1, 2, 6, 30, 210)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (primorial(10) == listOf(1, 2, 6, 30, 210, 2310, 30030, 510510,
                                9699690, 223092870)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
