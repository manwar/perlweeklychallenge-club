fun tsp(tree: List<List<Int>>): Int {
    var mp=0
    for (r in tree) {
        val rt = r.minOrNull()
        if (rt != null) {
            mp += rt
        }
    }
    return mp
}

fun main() {
  if (tsp(listOf(listOf(1),listOf(5,3),listOf(2,3,4),listOf(7,1,0,2),listOf(6,4,5,2,8))) == 8) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")
  if (tsp(listOf(listOf(5),listOf(2,3),listOf(4,1,4),listOf(0,1,2,3),listOf(7,2,4,1,9))) == 9) {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
