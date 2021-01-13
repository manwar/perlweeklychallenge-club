# Perl Weekly Challenge 072

Solution by Simon Green.

No solutions for last week as I was moving interstate. I'm back on board this week :)

## TASK #1 › Trailing Zeroes

When you think about it, a trailing zero is a product of 10, which is 2 × 5. Forgetting about the twos (since every second number is even), the five occurs every 5 numbers. Thus the factorial from 1 to 4 will contain no trailing zeros, 5-9 one trailing zero, 10-14 three trailing zeros, and so on. Once you reach 25, it gets a little more complicated as 25 is 5 × 5. Anyway, I digress from the actual task.

For this task, I take the input, calculate the factorial value, I then use a regular expression to find the trailing zeros (if any), and then display it.

### Examples

    » ./ch-1.pl 10
    2

    » ./ch-1.pl 7
    1

    » ./ch-1.pl 4
    0

## TASK 2 › Lines Range

This tasks was relatively simple. Read the file, skip the lines < `$A` and exit the loop once line `$B` is reached (or the end of file).

## Example

    » ./ch-2.pl input.txt 4 12
    L4
    L5
    L6
    L7
    L8
    L9
    L10
    L11
    L12