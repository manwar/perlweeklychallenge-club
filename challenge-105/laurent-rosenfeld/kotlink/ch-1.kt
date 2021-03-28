fun main() {
    val input = 248832;
    for (i in 1..10) {
        val root = "%12.3f".format(Math.pow(input * 1.0, 1.0/i))
        val formatted_i = "%2d".format(i)
        println("$formatted_i  $root")
    }
}
