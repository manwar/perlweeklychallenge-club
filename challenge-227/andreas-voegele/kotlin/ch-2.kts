#!/usr/bin/env kotlin

/*
 * Write a script to handle a 2-term arithmetic operation expressed in Roman
 * numeral.
 *
 * Example
 *
 * IV + V     to IX
 * M - I      to CMXCIX
 * X / II     to V
 * XI * VI    to LXVI
 * VII ** III to CCCXLIII
 * V - V      to nulla (they knew about zero but didn't have a symbol)
 * V / II     to non potest (they didn't do fractions)
 * MMM + M    to non potest (they only went up to 3999)
 * V - X      to non potest (they didn't do negative numbers)
 */

class Roman private constructor(val number: Double) {
    companion object {
        private val numberFor = mapOf(
            'I' to 1,
            'V' to 5,
            'X' to 10,
            'L' to 50,
            'C' to 100,
            'D' to 500,
            'M' to 1000,
        )

        private val numeralFor = listOf(
            1000 to "M",
            900 to "CM",
            500 to "D",
            400 to "CD",
            100 to "C",
            90 to "XC",
            50 to "L",
            40 to "XL",
            10 to "X",
            9 to "IX",
            5 to "V",
            4 to "IV",
            1 to "I",
        )

        fun decodeRoman(string: String): Int {
            val pair = string.map {
                numberFor.getOrDefault(it, 0)
            }.fold(0 to 0) { (sum, prev), next ->
                if (next <= prev) sum + prev to next else sum - prev to next
            }
            return pair.first + pair.second
        }

        fun encodeRoman(number: Int): String {
            if (number < 0 || number > 3999) {
                return "non potest"
            }
            if (number == 0) {
                return "nulla"
            }
            var string = ""
            var n = number
            for ((multiple, numeral) in numeralFor) {
                while (n >= multiple) {
                    n -= multiple
                    string += numeral
                }
            }
            return string
        }

        private fun encodeRoman(number: Double): String {
            val n = number.toInt()
            if (number.compareTo(n) != 0) {
                return "non potest"
            }
            return encodeRoman(n)
        }
    }

    constructor(string: String) : this(decodeRoman(string))

    constructor(number: Int) : this(number.toDouble())

    operator fun plus(other: Roman) = Roman(number + other.number)

    operator fun minus(other: Roman) = Roman(number - other.number)

    operator fun times(other: Roman) = Roman(number * other.number)

    operator fun div(other: Roman) = Roman(number / other.number)

    operator fun rem(other: Roman) = Roman(number % other.number)

    fun pow(other: Roman) = Roman(Math.pow(number, other.number))

    operator fun compareTo(other: Roman) = number.compareTo(other.number)

    operator fun inc() = Roman(number + 1.0)

    operator fun dec() = Roman(number - 1.0)

    fun toInt() = number.toInt()

    override fun toString() = encodeRoman(number)
}

println(Roman("IV") + Roman("V"))
println(Roman("M") - Roman("I"))
println(Roman("X") / Roman("II"))
println(Roman("XI") * Roman("VI"))
println(Roman("VII").pow(Roman("III")))
println(Roman("V") - Roman("V"))
println(Roman("V") / Roman("II"))
println(Roman("MMM") + Roman("M"))
println(Roman("V") - Roman("X"))
