  fun uniquesumzero(n: Int): List<Int> {
    if (n == 1) {
      return listOf(0)
    }
    var p = ArrayList(generateSequence(1) { it + 1 }.take(n - 1).toList())
    p.add(-n * (n-1) / 2)
    return p.toList()
  }

fun main() {

    if (uniquesumzero(5) == listOf(1, 2, 3, 4, -10)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquesumzero(3) == listOf(1, 2, -3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquesumzero(1) == listOf(0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
