fun exdigits(digits: List<Int>, start: Int, end: Int): Int {
    var x = 0
    for (i in start..end) {
        x *= 10
        x += digits[i]
    }
    return x
}

fun additivenumber(digitstring: String): Boolean {
    val digits = digitstring.toCharArray().map{it.digitToInt()}.toList()
    var stack = ArrayList<List<Int>>()
    for (i in 0 .. digits.size - 3) {
        for (j in i + 1 .. digits.size - 2) {
            stack.add(listOf(0, i, j))
        }
    }
    while (stack.size > 0) {
        val x = stack.removeLast()
        val start_a = x[0]
        val end_a = x[1]
        val start_b = end_a + 1
        val end_b = x[2]
        val val_ab = exdigits(digits, start_a, end_a) +
                     exdigits(digits, start_b, end_b)
        val start_c = end_b + 1
        for (end_c in start_c .. digits.size - 1) {
            if (val_ab == exdigits(digits, start_c, end_c)) {
                if (end_c == digits.size - 1) {
                    return true
                } else {
                    stack.add(listOf(start_b, end_b, end_c))
                    break
                }
            }
        }
    }
    return false
}

fun main() {

    if (additivenumber("112358")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!additivenumber("12345")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (additivenumber("199100199")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
