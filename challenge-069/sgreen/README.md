Solution by Simon Green
# Perl Weekly Challenge 069

## TASK #1 › Strobogrammatic Number

This is a lot harder than it looks. My first thought is to just do a foreach loop between `$a` and `$b` and add it to the list if the number is strobogrammatic. However when I ran

    perl -E '$b = 0; foreach my $a (0 ..  10**10) { $b++ } say $b;'

on my PC, that took nearly 3 minutes. With $b being up to 10<sup>15</sup> this was not a feasible approach. Even if I only had all the numbers between 1 and 10<sup>15</sup> containing only the digits 0, 6, 8, 9 that was still going to be in the billions.

So I took a different approach. I calculated the first half of all valid numbers, and then generated the second half. The logic is pretty simple. The first digit must be 6, 8 or 9 (as 0 isn't valid as a first digit). If the number of digits is odd, the middle number can only be 0 or 8.

Taking this approach, I can generate all 49,150 strobogrammatic numbers between 1 and 10<sup>15</sup> in less than half a second.

### Examples
    » ./ch-1.pl 50 100
    69 88 96

    » ./ch-1.pl 50 900
    69 88 96 609 689 808 888

## TASK #2 › 0/1 String

After the first task, these seemed a lot easier. But it wasn't entirely straight forward. I thought I had a bug in my code when it was spewing out digits on my screen. It turns out that is expected. The length of a number is twice the length of a previous number plus one. This meant the expected length was:

    1st  1
    2nd  3
    3rd  7
    4th  15
    5th  31
    10th 1,023
    15th 32,767
    20th 1,048,575
    25th 33,554,431
    30th 1,073,741,823

No wonder the task was changed from 1,000 iterations to 30! It goes without saying I'm not posting an example here, as the final line is 1,073,741,823 characters long.

Thankfully perl has a built in [reverse](https://perldoc.pl/functions/reverse) operator which does what you expect to do on a scalar (string). For the switch I used `tr/01/10/` which [translates](https://perldoc.pl/perlop#tr/SEARCHLIST/REPLACEMENTLIST/cdsr) the zeros to one and visa versa.