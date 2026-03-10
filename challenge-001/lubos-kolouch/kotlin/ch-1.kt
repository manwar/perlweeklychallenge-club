/**
 * Perl Weekly Challenge 001 - Task 1.
 *
 * Replace all lowercase 'e' with 'E' and return the number of replacements.
 */
object Challenge001Task1 {
    data class ReplaceResult(val count: Int, val replaced: String)

    fun replaceE(input: String): ReplaceResult {
        var count = 0
        val out = StringBuilder(input.length)

        for (c in input) {
            if (c == 'e') {
                out.append('E')
                count++
            } else {
                out.append(c)
            }
        }

        return ReplaceResult(count, out.toString())
    }

    private fun runTests() {
        val result = replaceE("Perl Weekly Challenge")
        check(result.count == 5) { "Expected count 5, got ${result.count}" }
        check(result.replaced == "PErl WEEkly ChallEngE") { "Unexpected replacement output: ${result.replaced}" }
        println("ok - task 1 example test passed")
    }

    @JvmStatic
    fun main(args: Array<String>) {
        if (args.isNotEmpty() && args[0] == "--test") {
            runTests()
            return
        }

        val result = replaceE("Perl Weekly Challenge")
        println(result.count)
        println(result.replaced)
    }
}
