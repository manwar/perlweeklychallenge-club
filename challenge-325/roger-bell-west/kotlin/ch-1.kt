fun consecutiveone(a: List<Int>): Int {
    var h = mutableMapOf<Int, Int>()
    h[0] = 0
    var latch = 0
    var latched = false
    a.forEachIndexed {i, n ->
                          if (n == 1 && !latched) {
                              latched = true
                              latch = i
                          }
                      if (n == 0 && latched) {
                          latched = false
                          h[latch] = i - latch
                      }
    }
    if (latched) {
        h[latch] = a.size - latch
    }
    return h.values.maxOrNull()!!
}

fun main() {

    if (consecutiveone(listOf(0, 1, 1, 0, 1, 1, 1)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (consecutiveone(listOf(0, 0, 0, 0)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (consecutiveone(listOf(1, 0, 1, 0, 1, 1)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
