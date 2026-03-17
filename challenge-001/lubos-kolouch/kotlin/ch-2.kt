/**
 * Perl Weekly Challenge 001 - Task 2.
 *
 * Return classic FizzBuzz values for numbers 1..20.
 */
object Challenge001Task2 {
    fun fizzBuzz(): List<String> {
        val output = ArrayList<String>()

        for (i in 1..20) {
            var line = ""
            if (i % 3 == 0) line = "fizz"
            if (i % 5 == 0) line += "buzz"
            if (line.isEmpty()) line = i.toString()
            output.add(line)
        }

        return output
    }

    private fun runTests() {
        val expected = listOf(
            "1", "2", "fizz", "4", "buzz", "fizz", "7", "8", "fizz", "buzz",
            "11", "fizz", "13", "14", "fizzbuzz", "16", "17", "fizz", "19", "buzz"
        )

        val got = fizzBuzz()
        check(got == expected) { "FizzBuzz output mismatch: $got" }
        println("ok - task 2 example test passed")
    }

    @JvmStatic
    fun main(args: Array<String>) {
        if (args.isNotEmpty() && args[0] == "--test") {
            runTests()
            return
        }

        fizzBuzz().forEach { println(it) }
    }
}
