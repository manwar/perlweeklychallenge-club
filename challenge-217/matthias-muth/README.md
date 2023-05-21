# Permutations really needed?
**Challenge 217 solutions in Perl by Matthias Muth**

## Task 1: Sorted Matrix

>You are given a `n x n` matrix where n >= 2. <br/>
Write a script to find `3rd smallest` element in the sorted matrix.

In Perl, a matrix is stored as an array of references to anonymous arrays containing the row data.<br/>
So all we need to do is to flatten the matrix into one single array,
then sort that array, and select its third elementas the result.
We just need to make sure that we sort numerically, not by string comparison as is the default.

All of this can be done in one line:
```perl
sub sorted_matrix {
    return ( sort { $a <=> $b } map @$_, @{$_[0]} )[2];
}
```

## Task 2: Max Number

>You are given a list of positive integers. <br/>
Write a script to concatenate the integers to form the highest possible value.

This challenge task caused a lot of thinking and trying before I ended up with
my final, very concise solution.

### Recursive permutations
I implemented a solution that goes through all permutations of the input list
to find the best order recursively.

A call to the subroutine uses each element of the list in turn as the first
part of the concatenation. In each iteration, a recursive call with the rest of the list,
with the current element removed (using `splice`) is used to determine the
best solution for that remaining list.
We store the maximum result of the combinations to return it as the result of the call.
```perl
sub max_number_permute {
    my ( @list ) = @_;

    return $list[0]
        if @list == 1;

    my $max = 0;
    for ( 0..$#list ) {
        my @sub_list = @list;
        splice @sub_list, $_, 1, ();
        my $try = $list[$_] . max_number( @sub_list );
        $max = $try
             if $try > $max;
    }
    return $max;
}
```

### In search of a non-recursive solution
I wondered whether it was really necessary to go through all permutations,
recursively or by other techniques.

If we are to find a solution that is not based on permutating the input list,
we need to sort the numbers so that their concatenation gives us the expected result
(knowing that 'sorting' is very similar to producing permutaions, but ok).

If we want to use a `sort`, we need to find a criteria for the comparison of
two numbers, to decide which of the two numbers goes first. <br/>
So I did a lot of thinking about how to recognize which one of the two
numbers is 'better'.

### Which number is 'better'?
We cannot just numerically compare the two numbers
for deciding which one will give us a higher result if it goes first,
This is because if we consider as an example the list `( 54, 6, 5 )`,
and we use this 'higher numerical value first' strategy,
we will get `54-6-5` as a result.
But actually the highest possible combination is `6-5-54`!

So actually, we should not compare the numbers as a whole, but
digit by digit.

Good that this is done more easily than is sounds,
because
we *can* use a numerical comparison if the numbers have the same length!
So if we do a numerical comparison of just the first \<n> digits of the numbers,
(with \<n> being the smaller length of the two numbers), we don't make a mistake.

If the \<n> digits differ,
we know which number gets us the highest possible next <n> digits in our result.
We will surely use that one first.

But what if the first \<n> digits are the same? <br/>
We then need to think about
what difference the trailing digits of the longer number can make.

What we know is that for the next digit \<n+1> in our result,
there will no other number in our list
that gives a higher value
than any of the two numbers we are currently checking.
Especially not the one that we just didn't use as the first one.
This is because all 'better' numbers from the list will already have made it
into the result before (like the `6` in the example above).

But what we also know is that if any number remaining in the rest of the list is 'worse'
than our shorter number, our shorter number will be the one that will be selected.

So alltogether this means that of all remaining numbers in the list,
the ones that are 'better' than our shorter number will have been taken already,
and the ones that are 'worse' than our shorter number will not make it
in subsequent comparisons against our shorter number.
Our shorter number is the only one that can ever compete
with the trailing digits of the longer one!

So we need to compare
the trailing digits against the shorter number.
Again, the comparison needs to be digit by digit.
Now it's getting complicated, because again, we might have different lengths.
...

### Much simpler: check the output instead of the input

At one point it came to me that there is a much simpler solution. <br/>
Instead of regarding the *input* numbers separately
for finding the 'better' one that should go first,
we can check the *output*
of combining the two numbers in one or the order order!
And clearly, the 'better' one of the two possible concatenations gives us which
number is the 'better' first one.

In a `sort` code block, where the two numbers to sort are `$a` and `$b`,
this means that this comparison will do the job:
```perl
{ "$b$a" <=> "$a$b" }
```
So possibly the shortest solution to this challenge task actually is this one-liner:
```perl
sub max_number {
    return join "", sort { "$b$a" <=> "$a$b" } @_;
}
```


## TestExtractor.pm
Apart from the two solutions that I have implemented this week
I have written a script that extracts the new task descriptions
from the
[Weekly Challenge web site](https://theweeklychallenge.org/blog/perl-weekly-challenge-217/)
and writes them into `challenge-<NN>/<USER>/perl/challenge-<NN>.txt`. <br/>
(I will publish that in one of the coming weeks.)

It also writes template files `perl/ch-1.pl` and `perl/ch-2-pl`, with
the challenge number and name, task number and name,
the subroutine name derived from the task name,
and even the input variable names and types, derived from the test data, already filled in.

I have a cron job that runs this every beginning of the week, so whenever there is a new
challenge, I can start coding right away!

The 'TestExtractor.pm' module extracts the test cases from that
task description file, and runs the tests for me,
without any editing of test data or test runs anymore.

I am sure that the effort of automating all of this will pay off very soon,
with every new challenge!

**Thank you for the challenge!**
