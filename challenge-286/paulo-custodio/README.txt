Challenge 286
https://theweeklychallenge.org/blog/perl-weekly-challenge-286/

Task 1: Self Spammer
Submitted by: David Ferrone
Write a program which outputs one word of its own script / source code at random. A word is anything between whitespace, including symbols.

Example 1
If the source code contains a line such as: 'open my $fh, "<", "ch-1.pl" or die;'
then the program would output each of the words { open, my, $fh,, "<",, "ch-1.pl", or, die; }
(along with other words in the source) with some positive probability.
Example 2
Technically 'print(" hello ");' is *not* an example program, because it does not
assign positive probability to the other two words in the script.
It will never display print(" or ");
Example 3
An empty script is one trivial solution, and here is another:
echo "42" > ch-1.pl && perl -p -e '' ch-1.pl

Task 2: Order Game
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, whose length is a power of 2.

Write a script to play the order game (min and max) and return the last element.

Example 1
Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
Output: 1

Operation 1:

    min(2, 1) = 1
    max(4, 5) = 5
    min(6, 3) = 3
    max(0, 2) = 2

Operation 2:

    min(1, 5) = 1
    max(3, 2) = 3

Operation 3:

    min(1, 3) = 1
Example 2
Input: @ints = (0, 5, 3, 2)
Output: 0

Operation 1:

    min(0, 5) = 0
    max(3, 2) = 3

Operation 2:

    min(0, 3) = 0
Example 3
Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
Output: 2

Operation 1:

    min(9, 2) = 2
    max(1, 4) = 4
    min(5, 6) = 5
    max(0, 7) = 7
    min(3, 1) = 1
    max(3, 5) = 5
    min(7, 9) = 7
    max(0, 8) = 8

Operation 2:

    min(2, 4) = 2
    max(5, 7) = 7
    min(1, 5) = 1
    max(7, 8) = 8

Operation 3:

    min(2, 7) = 2
    max(1, 8) = 8

Operation 4:

    min(2, 8) = 2
