fun finalscore(a: List<String>): Int {
    var p = ArrayList<Int>()
    for (n in a) {
        when (n) {
            "C" -> {
                p.removeLast()
            }
            "D" -> {
                p.add(2 * p.last())
            }
            "+" -> {
                p.add(p[p.size - 2] + p.last())
            }
            else -> {
                p.add(n.toInt())
            }
        }
    }
    return p.sum()
}

fun main() {

    if (finalscore(listOf("5", "2", "C", "D", "+")) == 30) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finalscore(listOf("5", "-2", "4", "C", "D", "9", "+", "+")) == 27) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finalscore(listOf("7", "D", "D", "C", "+", "3")) == 45) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finalscore(listOf("-5", "-10", "+", "D", "C", "+")) == -55) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (finalscore(listOf("3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+")) == 128) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
