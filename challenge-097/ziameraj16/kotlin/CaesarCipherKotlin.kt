import java.util.*

object CaesarCipherKotlin {

    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = Scanner(System.`in`);
        println("Enter a string")
        val str = scanner.nextLine()
        println("Enter offset")
        val offset = scanner.nextInt()
        println("Output: " + caesarCipher(str, offset))
    }

    private fun caesarCipher(str: String, offset: Int): String {
        val sb = StringBuilder()
        for(character in str.toCharArray()) {
            if (character == ' ') {
                sb.append(character)
                continue
            }
            val originalPosition = character - 'A'
            val newPosition = (originalPosition - offset) % 26
            var newCharacter = ('A'.toInt() + newPosition).toChar()
            if (newPosition < 0) {
                newCharacter = ('Z'.toInt() + (newPosition + 1)).toChar()
            }
            sb.append(newCharacter)
        }
        return sb.toString();
    }
}
