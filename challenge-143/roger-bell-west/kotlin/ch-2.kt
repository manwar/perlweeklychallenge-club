fun factorpairs(n: Int): ArrayList<Int> {
  if (n == 1) {
    return ArrayList(2)
  }
  var ff=ArrayList<Int>()
  var s=Math.sqrt(n.toDouble()).toInt()
  if (s*s == n) {
    ff.add(s*2)
    s--
  }
  for (pf in 2..s) {
    if (n % pf == 0) {
      ff.add(pf+n/pf)
    }
  }
  ff.add(n+1)
  return ff
}

fun is_stealthy(n: Int): Boolean {
  val p=factorpairs(n)
  if (p.count() == 1) {
    return false
  }
  for (ix in 0..p.count()-2) {
    for (iy in ix+1..p.count()-1) {
      if (Math.abs(p[ix]-p[iy])==1) {
        return true
      }
    }
  }
  return false
}

fun main() {
  if (is_stealthy(36)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")
  if (is_stealthy(12)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")
  if (!is_stealthy(6)) {
    println("Pass")
  } else {
    println("FAIL")
  }
}
