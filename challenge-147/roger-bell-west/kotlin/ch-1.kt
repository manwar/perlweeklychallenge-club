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

fun ltruncprimes(count: Int): ArrayList<Int> {
    var out=ArrayList<Int>()
    var lt=0
    val p=genprimes(500).map {it.toString()}
    var pp=mutableSetOf<String>()
    for (i in p) {
        pp.add(i)
    }
    for (pc in p) {
        val l=pc.length-1
        var c=true
        for (i in 1..l) {
            if (!pp.contains(pc.slice(i..l))) {
                c=false
                break
            }
        }
        if (c) {
            out.add(pc.toInt())
            lt += 1
            if (lt >= count) {
                break
            }
        }
    }
    return out
}

fun main() {
  if (ltruncprimes(20) == listOf(2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197)) {
    println("Pass")
  } else {
    println("FAIL")
  }
}
