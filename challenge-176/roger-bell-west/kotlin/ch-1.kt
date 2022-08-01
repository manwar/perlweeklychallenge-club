fun permutable(): Int {
    var n = 0
    while (true) {
        n += 1
        val base = n.toString().toCharArray().toList().sorted()
        var q = true
        for (k in 2..6) {
            val tt = (n*k).toString().toCharArray().toList().sorted()
            if (tt != base) {
                q = false
                break
            }
        }
        if (q) {
            return n
        }
    }
}

fun main() {
    if (permutable() == 142857) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
