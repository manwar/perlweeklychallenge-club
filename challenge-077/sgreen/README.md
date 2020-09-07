# Perl Weekly Challenge 076

Solution by Simon Green.

## TASK #1 › Prime Sum

I'm sure there is a CPAN module that can tell if a number is prime, but where is the fun in that? :) I created a function called `_is_prime` that determines if a number is a prime number. In short it calculate divisibility from `2 .. sqrt($n)`. It returns `0` ('is not a prime') when this happened. Otherwise it returns `1` to indicate the number is a prime.

Every positive integer (except 1) has a possible solution. Even numbers are made up of the sum of one or more twos, while odd numbers are made up of the sum of three and zero or more twos. Every prime (except 2 and 3) is the sum of smaller primes. For example, 5 = 2 +3, 7 = 5 + 2, etc.

With that in mind, the solution to find the least number of prime values to make up a number should be straight forward, as follows:

* Start with the target number in a `for` loop, and work backwards to 2
* Skip numbers that are not primes.
* Take that number from the target. If nothing remains, we have the solution, and can exit the loop. Otherwise, we `redo` the loop with the new target.
* The only exception is we don't use a prime number than is one less than the remain target. For example if we want to find the solution to the number 8, we can't use '7', as 1 is not a prime number, and we would come to an impossible situation.

### Examples

    » ./ch-1.pl 9
    Result is 2, made up of (7,2)

    » ./ch-1.pl 1000000000
    Result is 3, made up of (999999937,61,2)

## TASK 2 › Word Search

This task can be broken into the following sub-tasks:

1. Read the grid file and turn it to an array of arrays.
2. Read the word file, and turn that into an hash with the words as keys. The word list in Ubuntu includes words with apostrophes and some non-English characters, so we don't add those to the array. We also only add works 5 characters or longer, as the example does so too.
3. Create an array of directions pairs (rows and columns). -1 is left/up, 0 is no change and 1 is right/down. For example [-1, 1] is diagonally up and to the right. While [0, -1] is orthogonally to the left.
4. Work through each row and column as a starting point.
5. Go through each direction in the array and add letters in the specified direction from the start point until we reach the end of the row or column. If a word is in the word list, add it as a solution.
6. Sort and unique the solutions, and display all matching words.

## Examples
    » ./ch-2.pl example.txt /usr/share/dict/words
    aimed
    align
    antes

...

    virus
    viruses
    wigged
