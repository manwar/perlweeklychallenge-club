import java.util.*

object EditDistanceKotlin {
    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = Scanner(System.`in`)
        println("Enter first word")
        val s1 = scanner.next()
        println("Enter second word")
        val s2 = scanner.next()
        println("Output: " + editDistance(s1, s2))
    }

    private fun editDistance(s1: String, s2: String): Int {
        var len = s1.length
        if (s2.length < s1.length) {
            len = s2.length
        }
        var count = 0
        for (i in 0 until len) {
            if (s1[i] != s2[i]) {
                count++
            }
        }
        return count + Math.abs(s1.length - s2.length)
    }
}
