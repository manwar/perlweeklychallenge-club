import java.math.BigInteger

fun main () {
    var n = BigInteger("2")
    val one = BigInteger("1")
    for (i in 1..9) {
        n = n * (n - one) + one
        println(n)
    }
}
