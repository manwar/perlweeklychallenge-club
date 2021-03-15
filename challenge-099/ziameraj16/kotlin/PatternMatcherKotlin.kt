import java.util.*
import java.util.regex.Pattern

object PatternMatcherKotlin {
    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = Scanner(System.`in`)
        println("Enter regex pattern")
        val pattern = scanner.nextLine()
        println("Enter string to match")
        val str = scanner.nextLine()
        println("Output: " + patternMatch(str, pattern))
    }

    fun patternMatch(str: String?, pattern: String?): Int {
        return if (Pattern.matches(pattern, str)) 1 else 0
    }
}
