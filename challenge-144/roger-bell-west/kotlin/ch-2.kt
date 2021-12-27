fun ulam(u: Int, v: Int, ccount: Int): ArrayList<Int> {
    var ulams=arrayListOf<Int>(u,v)
    var sieve=ArrayList<Int>()
    var uc=v
    while (ulams.size < ccount) {
        for (i in sieve.size..uc+ulams[ulams.size-2]) {
            sieve.add(0)
        }
        for (i in 0..ulams.size-2) {
            sieve[uc + ulams[i] - 1] += 1
        }
        for (i in uc..sieve.size-1) {
            if (sieve[i] == 1) {
                uc=i+1
                ulams.add(uc)
                break
            }
        }
    }
    return ulams
}

fun main() {
  if (ulam(1,2,10) == listOf(1, 2, 3, 4,  6 , 8, 11, 13, 16, 18)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")
  if (ulam(2,3,10) == listOf(2, 3, 5, 7,  8,  9, 13, 14, 18, 19)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")
  if (ulam(2,5,10) == listOf(2, 5, 7, 9, 11, 12, 13, 15, 19, 23)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
