fun is_reversible(n: Int): Boolean {
    val sum = n + n.toString().reversed().toInt()
    val sumstr = sum.toString()
    for (i in 1..sumstr.length) {
        if (sumstr[i-1].toInt() % 2 == 0) {
            return false
        }
    }
    return true
}

fun main() {
    for (i in 1..100) {
        if (is_reversible(i)) {
            print("$i ")
        }
    }
    println(" ")
}
