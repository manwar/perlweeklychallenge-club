fun countsmaller(nums: List<Int>): List<Int> {
    val b = nums.sorted()
    var sm = mutableMapOf<Int, Int>()
    var l = 0
    b.forEachIndexed {i, e -> if (i == 0 || e != l) {
                          sm[e] = i
                          l = e
                      }
    }
    return nums.map{n -> sm.getValue(n)}
}

    
fun main() {

    if (countsmaller(listOf(8, 1, 2, 2, 3)) == listOf(4, 0, 1, 1, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countsmaller(listOf(6, 5, 4, 8)) == listOf(2, 1, 0, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (countsmaller(listOf(2, 2, 2)) == listOf(0, 0, 0)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
