# The Weekly Challenge 077

Solution by Simon Green.

## TASK #1 › Fibonacci Sum

One thing I noted with last week's [Prime Sum](https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/#TASK1/) is a few people went straight to the logic of returning 1 if the number is a prime, 2 if it is even or 2 more than a prime or 3 otherwise. While this is correct, I tend to tackle the problem at hand without looking at the quickest way to solve a task. As was the case with this week's solution.

The first part of this task was to generate a list of Fibonacci numbers up to and including the required sum. For this I started with an array of 1 and 2, and the added the last two numbers together until we reached or exceed the target figure.

For the main part of the task, I created a stack with all possible solutions. For each fibonnaci number, I added the new number, and added that number to all the existing values in the stack. For example, for values between 5-7, I would add 5 in the first iteration, add 3 and (3.5) in the second, and 2, (2,5), (2,3), (2,3,5) in the third. I discarded any value in the stack that was greater than the target number or the remainder of the stack is greater than the sum of the remaining numbers. In both these cases it would not be possible to find a solution.

Finally I counted the solutions that matched the target, and displayed the result.

### Examples

    » ./ch-1.pl 6
    RESULT IS 2
    5 + 1 = 6
    3 + 2 + 1 = 6


    » ./ch-1.pl 1000000
    RESULT IS 263
    832040 + 121393 + 46368 + 144 + 55 = 1000000
    514229 + 317811 + 121393 + 46368 + 144 + 55 = 1000000
    832040 + 121393 + 28657 + 17711 + 144 + 55 = 1000000
    514229 + 317811 + 121393 + 28657 + 17711 + 144 + 55 = 1000000
    ...

## TASK 2 › Lonely X

This is very similar to the Zero Matrix task from [Challenge 068](https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/), which incidentally was the first challenge I every did. This time we are using 'O' and 'X' instead of '0' and '1'.

Like that task, there are (at least) two ways to solve this challenge. One is to create a shadow grid that masks out the surrounding cells of a 'O' as not being lonely to a 'X'. The other is to calculate if an X is lonely as we evaluate each cell. I choose the later, purely because I did the former in challenge 068.

Once I've parsed the input, I validate that all the rows are the same length. I then go through each cells (rows and then columns). For each cell that is an 'X', I find out if there are any 'X's in the (up to) eight surrounding cells.

### Examples

    » ./ch-2.pl "[ O O X ]" "[ X O O ]" "[ X O O ]"
    Output is 1
    Matches: row 1 col 3

    » ./ch-2.pl "[ O O X O ]" "[ X O O O ]" "[ X O O X ]" "[ O X O O ]"
    Output is 2
    Matches: row 1 col 3, row 3 col 4
