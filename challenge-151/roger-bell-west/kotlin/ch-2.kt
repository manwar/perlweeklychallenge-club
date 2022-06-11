fun plan(houses: List<Int>): Int {
    val terminal=houses.size-2
    var b=ArrayList<ArrayList<Int>>();
    run {
        var cx=ArrayList<Int>();
        cx.add(0)
        b.add(cx)
    }
    var reward=0
    while (b.size > 0) {
        val c=b.removeLast()
        val c1=c[c.size-1]
        if (c1 >= terminal) {
            val r=c.map {houses[it]}.sum()
            if (r > reward) {
                reward=r
            }
        } else {
            for (n in c1+2..c1+3) {
                if (n >= houses.size) {
                    break
                }
                var j=ArrayList(c)
                j.add(n)
                b.add(j)
            }
        }
    }
    return reward
}

fun main() {
  if (plan(listOf(2, 4, 5)) == 7) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")
  if (plan(listOf(4, 2, 3, 6, 5, 3)) == 13) {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
