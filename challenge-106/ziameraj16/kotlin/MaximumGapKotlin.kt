import java.util.*
import java.util.stream.Collectors

object MaximumGapKotlin {
    @JvmStatic
    fun main(args: Array<String>) {
        println("Enter comma separated values")
        val scanner = Scanner(System.`in`)
        val input = scanner.nextLine()
        val arr = input.split(",").toTypedArray()
        val list = Arrays.stream(arr).mapToInt { s: String? -> Integer.valueOf(s) }.boxed().collect(Collectors.toList())
        println(findMaxGap(list))
    }

    private fun findMaxGap(list: List<Int>): Int {
        if (list.size == 1) {
            return 0
        }
        Collections.sort(list)
        var maxDiff = Int.MIN_VALUE
        var i = 0
        while (i < list.size - 1) {
            val diff = Math.abs(list[i + 1] - list[i])
            if (diff > maxDiff) {
                maxDiff = diff
            }
            i++
        }
        return maxDiff
    }
}
