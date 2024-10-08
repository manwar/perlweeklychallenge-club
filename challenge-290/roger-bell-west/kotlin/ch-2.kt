fun luhnalgorithm(a: String): Boolean {
    var digits = ArrayList(a
                               .toCharArray()
                               .filter{it >= '0' && it <= '9'}
                               .map{it.digitToInt()}
                               .reversed()
    )
    val payload = digits.removeAt(0)
    for (i  in 0 .. digits.size - 1 step 2) {
        digits[i] *= 2
        if (digits[i] > 9) {
            digits[i] -= 9
        }
    }
    return 10 - (digits.sum() % 10) == payload
}

fun main() {

    if (luhnalgorithm("17893729974")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (luhnalgorithm("4137 8947 1175 5904")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!luhnalgorithm("4137 8974 1175 5904")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
