/** ************************************************************************* **
 * ## Task 1: Percentage of Character
 *
 * **Submitted by:** [Mohammad Sajid Anwar][2]
 *
 * You are given a string, `$str` and a character `$char`.
 *
 * Write a script to return the percentage, nearest whole, of given character in
 * the given string.
 *
 * **Example 1**
 *
 * ```
 * Input: $str = "perl", $char = "e"
 * Output: 25
 * ```
 *
 * **Example 2**
 *
 * ```
 * Input: $str = "java", $char = "a"
 * Output: 50
 * ```
 *
 * **Example 3**
 *
 * ```
 * Input: $str = "python", $char = "m"
 * Output: 0
 * ```
 *
 * **Example 4**
 *
 * ```
 * Input: $str = "ada", $char = "a"
 * Output: 67
 * ```
 *
 * **Example 5**
 *
 * ```
 * Input: $str = "ballerina", $char = "l"
 * Output: 22
 * ```
 *
 * **Example 6**
 *
 * ```
 * Input: $str = "analitik", $char = "k"
 * Output: 13
 * ```
 *
 * [2]: https://manwar.org/
 * ************************************************************************** */

// the factor to convert a decimal to a percentage
const PERCENTAGE_FACTOR = 100;

function percentageOfCharacter(str: string, char: string): number {
  // the length of the string becomes the denominator
  const length = str.length;
  // the count of the character becomes the numerator
  const characters = str.split('');
  // filter the characters that match the given character
  const matchingCharacters = characters.filter((c) => c === char);
  // count the matching characters
  const matchingCharactersCount = matchingCharacters.length;
  // calculate the percentage
  const decimalPercentage = matchingCharactersCount / length;
  // convert the percentage to a number out of 100
  const percentage = decimalPercentage * PERCENTAGE_FACTOR;
  // round the percentage to the nearest whole number
  const roundedPercentage = Math.round(percentage);
  // return the rounded percentage
  return roundedPercentage;
}

export default percentageOfCharacter;
