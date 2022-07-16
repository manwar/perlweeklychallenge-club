import java.math.BigInteger

fun sylvester(ct: Int): ArrayList<BigInteger> {
    var o = arrayListOf(BigInteger("2"))
    val one = BigInteger("1")
    for (i in 2..ct) {
        val x = o[o.size - 1]
        o.add(one + (x * (x - one)))
        }
        return o
    }

fun main() {
    if (sylvester(10) == listOf(
            BigInteger("2"),
            BigInteger("3"),
            BigInteger("7"),
            BigInteger("43"),
            BigInteger("1807"),
            BigInteger("3263443"),
            BigInteger("10650056950807"),
            BigInteger("113423713055421844361000443"),
            BigInteger("12864938683278671740537145998360961546653259485195807"),
            BigInteger("165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443")
        )) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
