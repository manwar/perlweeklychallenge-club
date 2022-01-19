import kotlin.math.*

fun genprimes(mx: Int): ArrayList<Int> {
    var primesh=mutableSetOf<Int>()
    for (i in 2..3) {
        primesh.add(i)
    }
    for (i in 6..mx step 6) {
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

fun nthprime(n: Int): Int {
    var m=15
    if (n >= 6) {
        val nn=n.toDouble()
        m=1+(nn*ln(nn*ln(nn))).toInt()
    }
    val primes=genprimes(m)
    return primes[n-1]
}

fun main() {
  if (nthprime(10001) == 104743) {
    println("Pass")
  } else {
    println("FAIL")
  }
}
