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

fun isnumpal(c0: Int): Boolean {
    var c = c0
    var j = 0
    while (c > 0) {
        j = 10*j + c%10
        c /= 10
    }
    return c0 == j
}

fun primepal(pmax: Int): List<Int> {
    return genprimes(pmax).filter {isnumpal(it)}
}

fun main() {
    if (primepal(1000) == listOf(2, 3, 5, 7, 11, 101, 131, 151, 181,
                                 191, 313, 353, 373, 383, 727, 757,
                                 787, 797, 919, 929)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
