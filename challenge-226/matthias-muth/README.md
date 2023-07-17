# Reduce to the max
**Challenge 225 solutions in Perl by Matthias Muth**

The tasks of this challenge are good ones,
in the sense that the solutions can be short, nice, well-arranged, clear -- perly!

However the second task took me some time to understand what really is happening
in the task description and in the examples.

But let's start with the first one:

## Task 1: Max Words

> You are given a list of sentences, @list.<br/>
> A sentence is a list of words that are separated by a single space with no leading or trailing spaces.<br/>
> Write a script to find out the maximum number of words that appear in a single sentence.<br/>
> <br/>
> Example 1<br/>
> Input: @list = (qw/Perl and Raku belong to the same family./,<br/>
>                 qw/I love Perl./,<br/>
>                 qw/The Perl and Raku Conference./)<br/>
> Output: 8<br/>
> <br/>
> Example 2<br/>
> Input: @list = (qw/The Weekly Challenge./,<br/>
>                 qw/Python is the most popular guest language./,<br/>
>                 qw/Team PWC has over 300 members./)<br/>
> Output: 7<br/>

Perl in its own realm.<br/>
So short that it probably needs some explanations...

We get a list of strings, each one containing one sentence.

So let's split up each sentence into 'words' using `split " ", $_`,
getting our `$_` from using `map` walking us through the list of sentences.

The number of words in each sentence is `scalar` of the list of words that we just got.

And `max(...)` (from `List::Util`) gets us the largest one.

Voilà!

```perl
use List::Util qw( max );

sub max_words {
    my ( @list ) = @_;
    return max( map { scalar split " ", $_ } @list );
}
```

## Task 2: Left Right Sum Diff

> You are given an array of integers, @ints.<br/>
> Write a script to return left right sum diff array as shown below:<br/>
> @ints = (a, b, c, d, e)<br/>
> @left  = (0, a, (a+b), (a+b+c))<br/>
> @right = ((c+d+e), (d+e), e, 0)<br/>
> @left_right_sum_diff = ( | 0 - (c+d+e) |,<br/>
>                          | a - (d+e)   |,<br/>
>                          | (a+b) - e   |,<br/>
>                          | (a+b+c) - 0 | )<br/>
> <br/>
> Example 1:<br/>
> Input: @ints = (10, 4, 8, 3)<br/>
> Output: (15, 1, 11, 22)<br/>
> @left  = (0, 10, 14, 22)<br/>
> @right = (15, 11, 3, 0)<br/>
> @left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)<br/>
>                      = (15, 1, 11, 22)<br/>
> <br/>
> Example 2:<br/>
> Input: @ints = (1)<br/>
> Output: (0)<br/>
> @left  = (0)<br/>
> @right = (0)<br/>
> @left_right_sum_diff = ( |0-0| ) = (0)<br/>
> <br/>
> Example 3:<br/>
> Input: @ints = (1, 2, 3, 4, 5)<br/>
> Output: (14, 11, 6, 1, 19)<br/>
> @left  = (0, 1, 3, 6, 10)<br/>
> @right = (14, 12, 9, 5, 0)<br/>
> @left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)<br/>
>                      = (14, 11, 6, 1, 10)<br/>

Maybe I don't fully understand the definition,
but for me, there seems to be a little inconsistency between the definition and the examples.
In the definiton we have 5 elements as input, but only 4 elements in the left and right sums,
whereas all the examples are explained using arrays of left and right sums
that have the same number of elements as the input array.<br/>
I decided in favor of the examples. :-)

For this task, I completely avoided writing any for loops,
and based my solution on list-processing functions:
* `reductions` from `List::Util` does the summing up of the 'left' sum,
starting with a 0 and going through all input elements except the last one (to get the correct number of elements),
* `reductions` from `List::Util` also does the summing up of the 'right' sum,
starting with a 0 and going through the input elements *in reverse order*,
leaving out the first element, and then doing another `reverse` to have the 0 at the end of the list,
* `pairwise` from the `List::MoreUtils` module from CPAN then builds the list of differences
between corresponding elements of the 'left' and 'right' arrays.
 
So actually the task can be solved using three lines of actual code:

```perl
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw( reductions );
use List::MoreUtils qw( pairwise );

sub left_right_sum_diff( @ints ) {
    my @left  = reductions { $a + $b } 0, @ints[ 0 .. $#ints - 1 ];
    my @right = reverse reductions { $a + $b } 0, reverse @ints[ 1 .. $#ints ];
    return pairwise { abs( $a - $b ) } @left, @right
}
```

#### **Thank you for the challenge!**
