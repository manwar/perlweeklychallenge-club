# Perl Weekly Challenge 074

Solution by Simon Green.

## TASK #1 › Majority Element

This was a relatively straight forward task, with the following steps.

1. Count the number of times each elements occurs, and put it in a hash
2. Go through the hash, and return the hash key if the hash value (number of times it appears) is greater than half the length of the list. We can also exit, since only one value can meet the condition.
3. If we haven't exited, return '-1' as no value appears more than half the time.

### Examples
    » ./ch-1.pl 1 2 2 3 2 4 2
    2

    » ./ch-1.pl 1 3 1 2 4 5
    -1


## TASK 2 › FNR Character

This taks requires a bit more thought about how to solve it. This of course is a good thing since we don't want all tasks to be too easy.

This is how I attacked it. It will be interesting if other contributors took a different approach.

1. Split the string into an array called `@letters`.
2. Work through the list (left to right) from `0` to `$#letters`. `$#` is a short cut for one less than the length of the array, assuming you don't mess with `$[` (and you NEVER want to do that!)
3. Add that letter to the `%used` array to count the number of times it is used.
4. Work backwards (right to left) from the current letter to the first letter. For each letter, if it has been used once, print it. If no letters are found, print '#'
5. Print the new line character `\n`

## Examples

    » ./ch-2.pl ababc
    abb#c

    » ./ch-2.pl xyzzyx
    xyzyx#
