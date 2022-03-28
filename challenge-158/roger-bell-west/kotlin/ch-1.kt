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

fun digitsum(x0: Int): Int {
    var s=0
    var x=x0
    while (x > 0) {
        s += x % 10
        x /= 10
    }
    return s
}

fun additiveprimes(mx: Int): ArrayList<Int> {
    var o=ArrayList<Int>()
    val p=genprimes(mx)
    val ps=p.toSet()
    for (q in p) {
        if (ps.contains(digitsum(q))) {
            o.add(q)
        }
    }
    return o
}

fun main() {
    if (additiveprimes(100) == listOf(2, 3, 5, 7, 11, 23, 29, 41, 43,
                                      47, 61, 67, 83, 89)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
