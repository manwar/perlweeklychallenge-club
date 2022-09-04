fun main() {
    val tests  = arrayOf("Perl Weekly Challenge", "Long Live Perl")
    for (test in tests) {
        var his = mutableMapOf<Char,Int>() // letter histogram
        val chars = test.toCharArray()
        for (ch in chars) {
            his[ch] = if (his.containsKey(ch)) his[ch]!! + 1 else 1
        }
        for (i in 0..chars.size) {
            if (his[chars[i]] == 1) {
                println(test + ": " + i)
                break
            }
        }
    }
}
