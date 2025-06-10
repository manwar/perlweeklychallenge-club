fun finalprice(a: List<Int>): List<Int> {
    var out = ArrayList<Int>()
    a.forEachIndexed {i, n ->
                          var discount = 0
                      for (mi in i + 1 .. a.size - 1) {
                          if (a[mi] <= n) {
                              discount = a[mi]
                              break
                          }
                      }
                      out.add(n - discount)
    }
    return out.toList()
}

fun main() {

    if (finalprice(listOf(8, 4, 6, 2, 3)) == listOf(4, 2, 4, 2, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finalprice(listOf(1, 2, 3, 4, 5)) == listOf(1, 2, 3, 4, 5)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finalprice(listOf(7, 1, 1, 5)) == listOf(6, 0, 1, 5)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
