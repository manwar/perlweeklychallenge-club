# Perl Weekly Challenge 073

Solution by Simon Green.

## TASK #1 › Min Sliding Window

I try not to use CPAN modules, since there is no guarantee that the user running the code has it installed. However, [List::Util](https://metacpan.org/pod/List::Util) is part of the perl core these days, so it should be safe.

The hardest part of the challenge was taking a string and converting it into an array of integers. Originally I had `split /[^\d\-]+/`, but this didn't work as expected as the first and value would be `undef` if the first character was not a number. Nothing that a quick [search on Stack Overflow](https://stackoverflow.com/questions/2884549/how-can-i-capture-multiple-matches-from-the-same-perl-regex) doesn't fix :)

Once the input is processed, I then work through the array and get the [minimum value](https://metacpan.org/pod/List::Util#min) for each subset of the array.

### Examples

    » ./ch-1.pl "(1, 5, 0, 2, 9, 3, 7, 6, 4, 8)" 3
    0, 0, 0, 2, 3, 3, 4, 4

## TASK 2 › Smallest Neighbour

Originally I didn't understand what was required, so I reached out to Mohammad to clarify the task. In particular, I couldn't understand how the third value in the first example was '0'. I should have read the task more clearly.

Like with the first task, I walked through the list. If the current value was less than the previous minimum values, I would add a '0' to the result and set the new `$current_min` value. If it was not less, I would add the `$current_min` value to the result.

## Example

    » ./ch-2.pl 7 8 3 10 12
    0, 7, 0, 3, 3

    » ./ch-2.pl 4 6 5
    0, 4, 4