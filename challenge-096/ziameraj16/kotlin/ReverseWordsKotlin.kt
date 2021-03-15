import java.util.*

object ReverseWordsKotlin {
    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = Scanner(System.`in`)
        println("Enter the string")
        val str = scanner.nextLine()
        println("Reversed string is: " + reverseWords(str))
    }

    fun reverseWords(str: String): String {
        val strWithSingleSpace = str.trim { it <= ' ' }.replace(" +".toRegex(), " ").split(" ".toRegex()).toTypedArray()
        val list = Arrays.asList(*strWithSingleSpace)
        Collections.reverse(list)
        return java.lang.String.join(" ", list)
    }
}
