fun semiprime(mx: Int): ArrayList<Int> {
    val mxx: Int=mx/2
    var primesh=mutableSetOf<Int>()
    for (i in 2..mxx) {
        primesh.add(i)
    }
    var p: Int=2
    while (p*p <= mxx) {
        if (primesh.contains(p)) {
            for (i in p*p..mxx step p) {
                primesh.remove(i)
            }
        }
        if (p==2) {
            p -= 1
        }
        p += 2
    }
    var primes=ArrayList(primesh.distinct())
    primes.sort()
    var semiprimesh=mutableSetOf<Int>()
    for (i in 0..primes.size-1) {
        for (j in i..primes.size-1) {
            val t=primes[i]*primes[j]
            if (t < mx) {
                semiprimesh.add(t)
            } else {
                break
            }
        }
    }
    var semiprimes=ArrayList(semiprimesh.distinct())
    semiprimes.sort()
    return semiprimes
}

fun main() {
  if (semiprime(100) == listOf(4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95)) {
    println("Pass")
  } else {
    println("FAIL")
  }
}
