# Tune in to the right frequency!
**Challenge 233 solutions in Perl by Matthias Muth**

## Task 1: Similar Words

> You are given an array of words made up of alphabets only.<br/>
> Write a script to find the number of pairs of similar words. Two words are similar if they consist of the same characters.<br/>
> <br/>
> Example 1<br/>
> Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")<br/>
> Output: 2<br/>
> Pair 1: similar words ("aba", "aabb")<br/>
> Pair 2: similar words ("bac", "aabc")<br/>
> <br/>
> Example 2<br/>
> Input: @words = ("aabb", "ab", "ba")<br/>
> Output: 3<br/>
> Pair 1: similar words ("aabb", "ab")<br/>
> Pair 2: similar words ("aabb", "ba")<br/>
> Pair 3: similar words ("ab", "ba")<br/>
> <br/>
> Example 3<br/>
> Input: @words = ("nba", "cba", "dba")<br/>
> Output: 0<br/>

### Alphabet words
To decide whether two words are 'similar' in the sense of this challenge task,
we first compute each word's 'alphabet word'.<br/>
An alphabet word consists of one of each of the letters contained in the word,
ordered alphabetically and concatenated into a string.<br/>
Examples:
```
    "aba"       => "ab"
    "aabb"      => "ab"
    "bac"       => "abc"
    "challenge" => "aceghln"
```
Then, two words are 'similar' if their alphabet words are equal.<br/>

For computing the alphabet words of an input word,
we split the word up into single characters,
let `uniq` remove the doubles,
the `sort` them in string comparison oder (which is the default),
and `join` them into a single string.

We then keep a counter (or *frequency*!) of how often the same alphabet word
was produced,
which gives us the number of similar words for each alphabet
which we will need in the next step.

### Counting the pairs
We are asked to get the number of *pairs* of 'similar' words.

Now we could go and produce all combinations of two out of any $n$ words
that we found being similar.<br/>
But we won't!<br/>
We are not asked for all the pairs, but just for *how many* there are.<br/>
So let's compute the number of pairs without actually producing them.

For getting the number of possible pairs, if $n$ is the number of words
that have the same alphabet, we have $n$ ways to choose the first element
of the pair, and $(n-1)$ to choose the second one.
As we don't want to count the same pair again when it's just reversed,
we divide by two.

Actually this corresponds to the more scientific form of computing
the 'n choose k' combinations, which is

```math
    \binom{n}{k} = \frac{n!}{k!(n-k)!}
```
For $k = 2$ we get
```math
    \binom{n}{2} = \frac{n!}{2(n-2)!}
              = \frac{ n (n-1) (n-2) \dots 1 )}{2 ( (n-2) \dots 1 )}
              = \frac{n (n-1)}{2}
```

So the whole thing of computing and returning the number of pairs fits into one line,
which even includes summing up the pairs of all different alphabets.

The complete solution looks like this:
```perl
use List::Util qw( sum uniq );

sub similar_words( @words ) {

    my %alphabet_counts;
    for my $word ( @words ) {
        my $alphabet = join "", sort( uniq( split "", $word ) );
        ++$alphabet_counts{$alphabet};
    }

    return sum( map $_ * ( $_ - 1 ) / 2, values %alphabet_counts );
}
```

## Task 2: Frequency Sort

> You are given an array of integers.<br/>
> Write a script to sort the given array in increasing order based on the frequency of the values.
> If multiple values have the same frequency then sort them in decreasing order.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (1,1,2,2,2,3)<br/>
> Ouput: (3,1,1,2,2,2)<br/>
> '3' has a frequency of 1<br/>
> '1' has a frequency of 2<br/>
> '2' has a frequency of 3<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (2,3,1,3,2)<br/>
> Ouput: (1,3,3,2,2)<br/>
> '2' and '3' both have a frequency of 2, so they are sorted in decreasing order.<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (-1,1,-6,4,5,-6,1,4,1)<br/>
> Ouput: (5,-1,4,4,-6,-6,1,1,1)<br/>

What sounds very complicated actually is not really difficult at all.

### Frequencies
For each number in the list we compute the frequency with which it occurs in the list.<br/>
We could use a typical Perl idiom for this:
```perl
    my %frequencies;
    ++$frequencies{$_}
        for @ints;
```

Whenever I have a for loop, I look for an alternative
that hides the loop in a function call.
In this case, `frequency` from `List::MoreUtils` does exactly what we need:
```perl
    use List::MoreUtils qw( frequency );
    my %frequencies = frequency @ints;
```
Looks nice!<br/>
But alas, I've made a little benchmark to check the performance of these two solutions,
and sadly it turns out that the `for` loop
is consistently around twice as fast than calling the `frequency` function
no matter the size of the input list.<br/>
I suppose that it is the need of copying 
the whole list of values as the parameter list for the function call
that slows it down. 

So let's stay with DIY in this case.

### Sort, clever!
Now we have all the data to do the sorting, in one go!<br/>
Great that `sort` lets us specify the ordering criteria in a code block.<br/>
And also great that the three way comparison operators (`<=>` or `cmp`)
chain so nicely:
when the first comparison results in 'equal' operands it returns a zero,
which is considered a 'false' value,
and a simple `||` then let's the second comparison decide:
```perl
    sort { $frequencies{$a} <=> $frequencies{$b} || $b <=> $a } @ints;
```

Which makes the complete solution for this task quite short:
```perl
sub frequency_sort_core( @ints ) {
    my %frequencies;
    ++$frequencies{$_}
        for @ints;
    return sort { $frequencies{$a} <=> $frequencies{$b} || $b <=> $a } @ints;
}
```

##

## Note 1: Perl version
I am using Perl v5.38 now,
because I am playing around with the new `class` feature in other little projects,
which works great even in the 'minimum viable' form that was added as *experimental*
in that version (5.38).

The solutions described here do not use the `class` feature, but they use function signatures,
which I don't want to miss anymore.<br/>
The simplest way of enabling them is to use this simple line of boilerplate code:
```perl
use v5.36;
```
This gets you function prototypes, `say` and many other useful 'modern' things,
without needing to list them all separately, and it enables 'strict' and 'warnings'.<br/>
Love it!

What I actually have in the code is this,
to make it easier for anyone to play around with it even if they don't have Perl v5.36:
```perl
use v5.20;
use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';
```

## Note 2: TestExtractor.pm
My [code](perl) also includes [`TestExtractor.pm`](perl/TestExtractor.pm),
which extracts the example test data from a text version of the challenge tasks
(extracted from the [website](https://theweeklychallenge.org/) by another script every monday ;-),
and runs the tests.

## 
#### **Thank you for the challenge!**
