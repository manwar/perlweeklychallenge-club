# Challenge 260 tasks: Unique Occurrences and Non-unique Permutations
**Challenge 260 solutions in Perl by Matthias Muth**

## Task 1: Unique Occurrences

> You are given an array of integers, @ints.<br/>
> Write a script to return 1 if the number of occurrences of each value in the given array is unique or 0 otherwise.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (1,2,2,1,1,3)<br/>
> Output: 1<br/>
> The number 1 occurred 3 times.<br/>
> The number 2 occurred 2 times.<br/>
> The number 3 occurred 1 time.<br/>
> All occurrences are unique, therefore the output is 1.<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1,2,3)<br/>
> Output: 0<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)<br/>
> Output: 1<br/>

We are supposed to check whether 'the number[s] of occurrences of each value'
are unique.
That means that as a first step, we need to get these 'numbers of occurrences'
for each value. In other words, we do a frequency count for the values in the
array.
```perl
    my %freq;
    ++$freq{$_}
        for @ints;
```
Now we need to be careful about the fact that it's not the values themselves
that need to be unique, but the *number* of values.
So we need to check that every *frequency value* appears exactly once.
We can verify this by a call to `uniq` from the `List::Util` core module,
comparing the number of distinct frequency values to their total number.
If they are equal, every frequency value appears exactly once.

This is the whole thing, returning a `1` or `0` depending on whether the
condition is met or not:
```perl
use v5.36;
use List::Util qw( uniq );

sub unique_occurrences( @ints ) {
    my %freq;
    ++$freq{$_}
	for @ints;
    return uniq( values %freq ) == scalar values %freq ? 1 : 0;
}
```

## Task 2: Dictionary Rank

> You are given a word, \$word.<br/>
> Write a script to compute the dictionary rank of the given word.<br/>
> <br/>
> Example 1<br/>
> Input: \$word = 'CAT'<br/>
> Output: 3<br/>
> All possible combinations of the letters:<br/>
> CAT, CTA, ATC, TCA, ACT, TAC<br/>
> Arrange them in alphabetical order:<br/>
> ACT, ATC, CAT, CTA, TAC, TCA<br/>
> CAT is the 3rd in the list.<br/>
> Therefore the dictionary rank of CAT is 3.<br/>
> <br/>
> Example 2<br/>
> Input: \$word = 'GOOGLE'<br/>
> Output: 88<br/>
> <br/>
> Example 3<br/>
> Input: \$​word = 'SECRET'<br/>
> Output: 255<br/>

I have solved several [Advent of Code](https://adventofcode.com) puzzles 
that involve permutations.
They often come in two parts, where the first one can be solved by
computing all permutations and then finding the solution by examining them.
In the second part however, typically the number of permutations to be checked
is raised so that you easily run out of space, or of computing time when you
use that strategy. You have to think of other ways to reduce the complexity.

In this challenge's examples, the maximum number of letters to permute 
is six.
The maximum number of permutations of $n!$ if there are $n$ letters and they
all are different.
Thus there are at most 720 permutations to compute in the examples
(actually only $\frac{6!}{2!2!} = 180$ for 'GOOGLE', containing 2 letters
that appear twice each, and $\frac{6!}{2!} = 360$ for 'SECRET', with its 'E'
appearing twice).

So for this challenge, I decided to use a simple, recursive approach to
generate all permutations in the right order,
without fearing to run out of memory or to need to wait for hours
for the results.

The numbering of permutations is complicated a bit by the fact that we have
letters that appear more than once.
We want to generate the permutations in alphabetical order
without repeating any words.
So even if a letter exists several times (like the 'G' or the 'O' in 'GOOGLE'),
we must use it only once when we loop through the letters for a given position.

A quite easy way to achieve this is to use a frequency hash (`%freq`)
as input for the recursive generator function.
The keys of the hash are the letters, of course,
and the values state how many times this character is available.

Doing so, `sort keys %freq` gives us the list of letters we can loop through,
without repetition,
to use in the first position of the resulting word.

For getting the possible permutations of the rest of the word,
we do a recursive call with the rest of available letters.
We need to adjust the frequency hash for that call,
by diminishing the frequency entry of that first letter by one,
and we remove the frequency entry completely if it has decreased to zero making it unavailable for the rest-permutations.

We combine all the permutations that are returned from the call with our
first letter, and add everything to a result list.
Then, for the next loop iteration,
we restore the frequency hash to its original state
by simply re-increasing the frequency entry
for the letter we just used as the first letter.

So here is that subroutine:
```perl
sub combinations( %freq ) {
    return keys %freq
	if %freq == 1 && ( values %freq )[0] == 1;
    my @combinations;
    for my $letter ( sort keys %freq ) {
	delete $freq{$letter}
	    if --$freq{$letter} == 0;
	push @combinations, map $letter . $_, combinations( %freq );
	++$freq{$letter};
    }
    return @combinations;
}
```

The main function consists of three parts:

* splitting up the input word onto a frequency hash,

* calling the resursive function to get all combinations,

* and walking through the combinations to find the matching number, returning it as the final result.

```perl
sub dictionary_rank( $word ) {
    my %freq;
    ++$freq{$_}
	for split "", $word;
    my @combinations = combinations( %freq );
    for ( 0..$#combinations ) {
	return 1 + $_
	    if $combinations[$_] eq $word;
    }
}
```

To improve this solution, I would think of actually not producing
and returning all the permutations.
Instead, we could pass in the word that we want the index of, and
and maybe some context information.
For the recursive calls, we then could return whether we found the word,
and if we did, its index, and if not, the number of permutations that were
tested.
This would still produce every single permutation, but not for storing them,
and we could return immediately after finding the index of the word.

The same thing could be achieved with an iterator that returns the next
permutation. A bit different to implement than the recursive approach.

And the there is [James Curtis-Smith's solution](https://www.facebook.com/groups/perlcommunity/permalink/1632932314181055/) to this challenge,
which does not even produce any permutation, but computes the index
based on the formula of how many permutations (or sub-permutations)
exist.<br/>
This is the solution that really scales well!<br/>
And it's a very nice read, too! Admirable!

#### **Thank you for the challenge!**
