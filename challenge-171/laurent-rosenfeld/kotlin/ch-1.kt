fun is_abundant(n: Int): Boolean {
    var sum = 0
    for (i in 2..(n/2 + 1).toInt()) {
        if (n % i == 0) {
            sum += i
            if (sum > n) {
                return true
            }
        }
    }
    return false
}
fun main() {
    val max = 20
    var count = 0
    var j = 1
    while (count < max) {
        if (is_abundant(j)) {
            print ("$j ")
            count++;
        }
        j += 2
    }
}
