import kotlin.math.*

fun genprimes(mx: Int): ArrayList<Int> {
    var primesh=mutableSetOf<Int>()
    for (i in 2..min(3, mx)) {
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

fun primecount(l: Int): Int {
    return genprimes(l-1).size
}

fun main() {
    if (primecount(10) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")

    if (primecount(15) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")

    if (primecount(1) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")

    if (primecount(25) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")
}
