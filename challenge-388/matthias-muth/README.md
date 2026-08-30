# Dyck Santa

**Challenge 388 solutions in Perl by Matthias Muth**

## Task 1: Dyck Words

> A Dyck Word of order `$n` is a string of length `2x$n` consisting of `$n` ‘U’ (Up) characters and `$n` ‘D’ (Down) characters such that no initial prefix of the string contains more ‘D’s than ‘U’s.<br/>
> Write a script to return a list of all valid Dyck words of length `2x$n`, sorted in lexicographical (alphabetical) order.
>
> **Example 1**
>
> ```text
> Input: $n = 1
> Output: ("UD")
> ```
>
> **Example 2**
>
> ```text
> Input: $n = 2
> Output: ("UDUD","UUDD")
> ```
>
> **Example 3**
>
> ```text
> Input: $n = 3
> Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")
> ```
>
> **Example 4**
>
> ```text
> Input: $n = 0
> Output: ("")
> ```
>
> **Example 5**
>
> ```text
> Input: $n = 4
> Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
>          "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
>          "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")
> ```

I solve this using a recursive approach. It is essentially a depth-first traversal of the graph of possible words. The nodes of the graph are partial words, with possible 'D' and possible 'U' edges leading to subsequent partial words.

Since 'D' comes before 'U' lexicographically, exploring the 'D' branch before the 'U' branch means that the resulting list is already sorted; no separate `sort` is necessary.

To add a 'U', remember that `$n` is the total number of 'U' characters that will be in the string at the end. We can keep track of how many 'U' characters are still available simply by decrementing `$n` every time we use one. Once `$n` reaches zero, we can't use any more 'U's, but we still can use 'D's.

To add a 'D', we need to make sure that at any time, there are no more 'D' characters that 'U' characters in the string (the 'prefix' rule in the task description).  

I picture this as a mountain range, with 'U' characters going 'up' the hill and 'D' characters going 'down'. We just cannot go below height zero. Since we eventually use `$n` 'U's and `$n` 'D's, we know that we will end at height zero.

To determine whether we can put a 'D' or not, we keep track of the current height of that 'mountain range'. A 'D' can be added whenever the height is greater than zero. At the beginning, the height *is* zero, so the first character cannot be a 'D', it always has to be a 'U'.

With these two pieces of data:

* `$n` - the 'Dyck word order', but at the same time the number of 'U' characters still left,
* `$h` - the current height of the 'mountain range', which is also the number of 'D' characters still left to come back down to zero height.

the solution can be implemented by a recursive subroutine:

```perl
    dyck_words( $n, $h )
```

It returns all possible combinations that, starting at height `$h`, use `$n` 'U' characters and `$h` 'D' characters. With `$h = 0`, these are exactly the Dyck words of order `$n`  (and therefore of length `2 * $n`) that the task requires.

The possible combinations are determined in two steps:

* checking whether a 'D' is possible, and if so, appending to that 'D' all combinations obtained by a recursion call with `$h` decremented by one, because the 'D' lowers the current height,
* checking whether a 'U' is possible, and if so, appending to that 'U' all combinations obtained by a recursion call with `$n` decremented by one, because one 'U' just has been used, and `$h` incremented by one, because the 'U' moves us up.

The recursion stops when neither a 'U' nor a 'D' can be added, which is the case if `$n == 0` and `$h == 0`.

For the main call, we only have `$n` given, and `$h` should be 0. This is a perfect use case for a default parameter (`$h = 0`) in the subroutine signature. In recursion calls, we give both `$n` and `$h` explicitly.

This is my implementation:

```perl
use v5.36;

sub dyck_words_rec( $n, $h = 0 ) {
    return "" if $n == 0 && $h == 0;
    return (
        $h > 0 ? ( map { "D" . $_ } dyck_words_rec( $n, $h - 1 ) ) : (),
        $n > 0 ? ( map { "U" . $_ } dyck_words_rec( $n - 1, $h + 1 ) ) : ()
    );
}
```

## Task 2: Secret Santa

> A company with $n employees is running a Secret Santa exchange. Each employee buys one gift and receives one gift.<br/>
> Write a script to return the total number of valid gift assignments where no employee receives the gift they originally bought (i.e., employee $i must not be assigned gift $i).
>
> **Example 1**
>
> ```text
> Input: $n = 1
> Output: 0
>
> Only 1 participant exists. They would have to receive their own gift, which is invalid.
> ```
>
> **Example 2**
>
> ```text
> Input: $n = 2
> Output: 1
>
> Participants 1 and 2 must swap gifts ([2, 1]).
> ```
>
> **Example 3**
>
> ```text
> Input: $n = 3
> Output: 2
>
> The 2 valid gift arrays where array[i] is who person i+1 receives from:
> [2, 3, 1]
> [3, 1, 2]
> ```
>
> **Example 4**
>
> ```text
> Input: $n = 4
> Output: 9
>
> The 9 valid arrays are:
> [2, 1, 4, 3], [2, 3, 4, 1], [2, 4, 1, 3],
> [3, 1, 4, 2], [3, 4, 1, 2], [3, 4, 2, 1],
> [4, 1, 2, 3], [4, 3, 1, 2], [4, 3, 2, 1],
> ```
>
> **Example 5**
>
> ```text
> Input: $n = 5
> Output: 44
>
> There are 44 valid permutations out of 5! = 120 total possible arrangements.
> ```

I first tried to find a formula for the number of permutations in which no element remains in its original position.

This can be stated as a problem in combinatorics:

>  In an experiment using $k$ numbered balls $(1 \dots k)$, how many ways are there to draw the balls so that ball $i$ is not drawn on draw $i$?

I first tried to find a formula for this number of permutations. I then thought that maybe it would be easier to develop the number of permutations that *do* have an element in its original position. This number can then be subtracted from the overall number of possible permutations to get the desired result.

In any case I didn't get too far.

Then I did a bit of searching, and I found that in combinatorial mathematics, our problem is called a *derangement* problem.

There is a great [Wikipedia article](https://en.wikipedia.org/wiki/Derangement) about it, and -- hold your breath -- there *is* a formula!
```math
D_{n}=n!\sum_{i=0}^{n}{\frac {(-1)^{i}}{i!}}\quad {\text{for}}\ n\geq 0
```
I was a bit relieved that, given the complexity of the derivation of the formula, I don't think I would have found it myself.

I was then astonished to discover that there is a non-iterative formula as well:

```math
D_{n}=\left[{\frac {n!}{e}}\right]=\left\lfloor {\frac {n!}{e}}+{\frac {1}{2}}\right\rfloor \quad {\text{for}}\ n\geq 1
```

or also

```math
D_{n} = \left\lfloor {\frac {n!+1}{e}}\right\rfloor \quad {\text{for}}\ n \geq 1
```

Wait, what? $e$?

That sounds crazy, but using `List::Util::product` to calculate $n!$, and `exp( 1 )` to calculate $e$, this actually works:

```perl
use v5.36;
use List::Util qw( product );

sub secret_santa( $n ) {
    return int( ( product( 1..$n ) + 1 ) / exp( 1 ) );
}
```

And of course it is blindingly fast!

For completeness, I also implemented a breadth-first search to generate all combinations, just to return their number in the end:

```perl
use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';

sub secret_santa_bfs( $n ) {
    my @results = ();
    my $assignment = [];
    my $gifts_available = [ undef, map true, 1..$n ];
    my @q = ( [ $assignment, $gifts_available ] );
    while ( @q ) {
        ( $assignment, $gifts_available ) = ( shift @q )->@*;
        if ( $assignment->@* == $n ) {
            push @results, $assignment;
            next;
        }
        my $participant = scalar $assignment->@* + 1;
        for ( 1..$n ) {
            next unless $gifts_available->[$_] && $_ != $participant;
            push @q, [
                [ $assignment->@*, $_ ],
                [ $gifts_available->@[ 0 .. ( $_ - 1 ) ],
                    false,
                    $gifts_available->@[ ( $_ + 1 ) .. $n ] ],
            ];
        }
    }
    return scalar @results;
}
```

I pushed the limit up to `$n = 10` in testing, which still returned a result in less than 10 seconds. But for `$n = 11`, the program exhausted the available memory and aborted.

Nice challenge! 

#### **Thank you for the challenge!**
