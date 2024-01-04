import kotlin.math.max

fun alphanumericstringvalue(a: List<String>): Int {
    var l = ArrayList<Int>()
    for (n in a) {
        val p: Int? = try { n.toInt() } catch (e: NumberFormatException) { n.length }
        l.add(p!!)
    }
    return l.maxOrNull()!!
}

fun main() {

    if (alphanumericstringvalue(listOf("perl", "2", "000", "python", "raku")) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alphanumericstringvalue(listOf("001", "1", "000", "0001")) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
