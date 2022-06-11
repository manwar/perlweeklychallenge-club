fun leftfactorial(mx: Int): ArrayList<Int> {
    var out=ArrayList<Int>()
    var fact=1
    var sum=0
    for (i in 0..mx-1) {
        if (i > 0) {
            fact *= i
        }
        sum += fact
        out.add(sum)
    }
    return out
}

fun main() {
  if (leftfactorial(10) == listOf(1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
