# The Weekly Challenge 078

Solution by Simon Green.

## TASK #1 › Leader Element

Both of these week's tasks seemed pretty straight forward, so there's not much commentary from me this week. For the first task, I worked through the array (left to right) and displayed the number if the value is greater than all the values to the right.

I manually added the last number as by definition (there are no values to the right), it will be greater (even if it is a negative integer).

An alternate solution would be to work right to left keeping count of the maximum seen value so far and display values that exceeded that value. Definitely more efficient, but a little more complex.

### Examples

    » ./ch-1.pl 9 10 7 5 6 1
    (10, 7, 6, 1)

    » ./ch-1.pl 3 4 5
    (5)

## TASK 2 › Left Rotation

For this task, I read in the two arrays and checked all the values in the second array were less than the number of items in the first array. I worked through the second array to display the rotated list using `@array[ $offset .. $#array, 0 .. $offset - 1 ]` to show the values in the correct order. The exception is when the offset was 0. In this case, I displayed the original array unaltered.

### Examples

    » ./ch-2.pl "(10 20 30 40 50)" "(3 4)"
    [40 50 10 20 30]
    [50 10 20 30 40]

    » ./ch-2.pl "(7 4 2 6 3)" "(1 3 4)"
    [4 2 6 3 7]
    [6 3 7 4 2]
    [3 7 4 2 6]