# Max Complication for Min Brute Force

**Challenge 339 solutions in Perl by Matthias Muth**

## Task 1: Max Diff

> You are given an array of integers having four or more elements.<br/>
> Write a script to find two pairs of numbers from this list (four numbers total) so that the difference between their products is as large as possible.<br/>
> In the end return the max difference.<br/>
> With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).
>
> **Example 1**
>
> ```text
> Input: @ints = (5, 9, 3, 4, 6)
> Output: 42
>
> Pair 1: (9, 6)
> Pair 2: (3, 4)
> Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (1, -2, 3, -4)
> Output: 10
>
> Pair 1: (1, -2)
> Pair 2: (3, -4)
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (-3, -1, -2, -4)
> Output: 10
>
> Pair 1: (-1, -2)
> Pair 2: (-3, -4)
> ```
>
> **Example 4**
>
> ```text
> Input: @ints = (10, 2, 0, 5, 1)
> Output: 50
>
> Pair 1: (10, 5)
> Pair 2: (0, 1)
> ```
>
> **Example 5**
>
> ```text
> Input: @ints = (7, 8, 9, 10, 10)
> Output: 44
>
> Pair 1: (10, 10)
> Pair 2: (7, 8)
> ```

As usual, I try not to use brute force to solve the task.<br/>I will *not* do 'combinations', and *not* go through $\binom{n}{4} = \frac{n!}{4!(n-4)!}$ iterations to choose the right numbers.

Instead, I will choose a small number of candidate pairs of numbers, based on the numbers' signs and their magnitudes.

My first observation is that for getting the largest difference, the first product has to be as high as possible, and the subtracted product has to be as low as possible.

Next observation:<br/>
The largest product can be obtained by multiplying the two largest numbers.<br/>
This should be an obvious one. But there is a huge BUT:

If we have at least two *negative* numbers in our list, and remembering that 'minus times minus equals plus', we might find that the largest (positive) product is obtained by multiplying the two *lowest* numbers (those with the largest absolute amounts).<br/>
So we have to consider the products of both the two highest positive numbers and the two lowest negative ones, and use the 'better' one. If we cannot compute both of them (for example because we don't have any negative numbers in the list), we will only use the one we have.

So it seems a good idea to separate the positive and the negative numbers into separate arrays, and have them sorted numerically, so that we can access the highest or lowest positive or negative numbers just by indexing into these arrays.

For the second pair of numbers, the one whose product we will subtract, we need to find the *lowest* product possible. This is special, because we might get lucky and even get a *negative* product, which would be good because negative numbers are 'low'.

So if we have negative numbers at all, we will use the lowest one (the one with the highest absolute value) that is still available (and was not used for the first product!), together with the highest positive number available.<br/>
We should then get a product as far in the negative as possible.

Thus, the candidates for **the first product** are these:

* the highest two positive numbers,
* the lowest two negative numbers (resulting in a positive product).

And the candidates for **the second product** are these:

* if we have positive and negative numbers:<br/>
  the lowest negative number times the highest positive number,<br/>
  because this results in a number as far in the negative (or as 'low') as possible,
* if we have no negative numbers:<br/>
  the product of the lowest two positive numbers, 
* if we have no positive numbers:<br/>
  the two negative numbers closest to zero (or zero itself, if we have one). 

Next observation:<br/>
There can be cases where the choice for the first product reduces the possible choices for the second product in a way that makes the combination of both not the best choice overall. Especially when there are only few numbers, and the choice of one product reduces the availability of numbers to choose from for the other one.

To be sure to deal correctly with this, my strategy is to try both:

* Find the two possible candidates for the best *first* product, as described above.<br/>Then choose the best *second* product from the numbers that each of those candidates left.
* Find the best *second* product chosen from all numbers.<br/>Then choose the best two possible *first* products from what is left.<br/>Actually, in that case, we need to consider a third possible candidate for the first product here: If we used a positive and a negative number for that second product, we might end up with only another 'mixed pair' left, while before, we were sure to have at least two positive *or* two negative numbers for the first pair. So in case we don't succeed in creating either of the two positive candidates for the first pair described above, we need to use what we have and create a negative first product. It still might be a good choice in combination with a good second product.

My implementations reflects the above, gathering the first and second pair of each different case in an array `@cases`, together with a case number for checking and debugging.<br/>Then, I feed the cases into `map` to compute the differences between the two products for each, with the product computed using `product`, and `max` used to get the best one:

```perl
use v5.36;
use List::Util qw( product max );

sub max_diff( @ints ) {
    my @positives = sort { $b <=> $a } grep $_ >= 0, @ints;
    my @negatives = sort { $b <=> $a } grep $_ < 0, @ints;

    my @cases = (
        # Try the highest two positive numbers as the first product,
        # with the second product as small as possible after having used
        # those two positive numbers:
        @positives >= 2 ? do {
            my $pair_1 = [ @positives[0,1] ];
            @positives >= 3 && @negatives
                ? [ "case 1", $pair_1, [ $positives[2], $negatives[-1] ] ] : (),
            @positives >= 2 && @negatives >= 2
                ? [ "case 2", $pair_1, [ @negatives[0,1] ] ] : (),
            @negatives == 0
                ? [ "case 3", $pair_1, [ @positives[-2,-1] ] ] : (),
        } : (),

        # Try the lowest two negative numbers as the first product,
        # with the second product as small as possible after having used
        # those two negative numbers:
        @negatives >= 2 ? do {
            my $pair_1 = [ @negatives[-2,-1] ];
            @negatives >= 3 && @positives
                ? [ "case 4", $pair_1, [ $positives[0], $negatives[-3] ] ] : (),
            @positives >= 2
                ? [ "case 5", $pair_1, [ @positives[-2,-1] ] ] : (),
            @positives == 0
                ? [ "case 6", $pair_1, [ @negatives[0,1] ] ] : (),
        } : (),

        # Try a negative second product using the best possible 'mixed pair',
        # with the three options for the first product after that.
        # For the first product, we then have one less positive and
        # one less negative available.
        @negatives && @positives ? do {
            my $pair_2 = [ $positives[0], $negatives[-1] ];
            @positives >= 3
                ? [ "case 7", [ @positives[1,2] ], $pair_2 ] : (),
            @negatives >= 3
                ? [ "case 8", [ @negatives[-3,-2] ], $pair_2 ] : (),

            # In case we couldn't create either of the two cases above,
            # we have to use a 'mixed pair' for the first product:
            @negatives <= 2 && @positives <= 2
                ? [ "case 9", [ $positives[1], $negatives[-2] ], $pair_2 ] : (),
        } : (),
    );

    return
        max( map product( $_->[1]->@* ) - product( $_->[2]->@* ), @cases );
}
```

My actual code (on [github](https://github.com/MatthiasMuth/perlweeklychallenge-club/blob/muthm-339/challenge-339/matthias-muth/perl/)) includes some additions for checking and debugging. The function can return the case number and the two number pairs that lead to the best combination if it is used in list context.

I also wrote two test scripts with additional tests. As most tests in Perl should , they reside in the [`t` subdirectory](https://github.com/MatthiasMuth/perlweeklychallenge-club/tree/muthm-339/challenge-339/matthias-muth/perl/t) , so that `prove` can be used to run them.

The [`t/ch-1-full-output.t`](https://github.com/MatthiasMuth/perlweeklychallenge-club/blob/muthm-339/challenge-339/matthias-muth/perl/t/ch-1-full-output.t) test script makes use of the added return values, and prints out which case was used for which test case, in the style used in the task description (see [`ch-1-full-output.txt`](https://github.com/MatthiasMuth/perlweeklychallenge-club/blob/muthm-339/challenge-339/matthias-muth/perl/ch-1-full-output.txt) for the captured output). 

These are the counts from the tests for each of the cases, showing that actually none of them is redundant: 

```text
case 1: 6 times
case 2: 9 times
case 3: 4 times
case 4: 5 times
case 5: 9 times
case 6: 2 times
case 7: 2 times
case 8: 1 time
case 9: 7 times
```

This might easily be the Weekly Challenge task that caused me longest to complete!<br/>Not only because it took some effort finding the cases, but I also changed the code structure several times until I was happy enough with the readability of the code.

I love this challenge!

## Task 2: Peak Point

> You are given an array of altitude gain.<br/>
> Write a script to find the peak point gained.
>
> **Example 1**
>
> ```text
> Input: @gain = (-5, 1, 5, -9, 2)
> Output: 1
> 
> start: 0
> 1st change:  0 + (-5) = -5
> 2nd change: -5 + 1    = -4
> 3rd change: -4 + 5    = 1
> 4th change:  1 + (-9) = -8
> 5th change: -8 + 2    = -6
> 
> max(0, -5, -4, 1, -8, -6) = 1
> ```
>
> **Example 2**
>
> ```text
> Input: @gain = (10, 10, 10, -25)
> Output: 30
> 
> start: 0
> 1st change:  0 + 10    = 10
> 2nd change: 10 + 10    = 20
> 3rd change: 20 + 10    = 30
> 4th change: 30 + (-25) = 5
> 
> max(0, 10, 20, 30, 5) = 30
> ```
>
> **Example 3**
>
> ```text
> Input: @gain = (3, -4, 2, 5, -6, 1)
> Output: 6
> 
> start: 0
> 1st change:  0 + 3    = 3
> 2nd change:  3 + (-4) = -1
> 3rd change: -1 + 2    = 1
> 4th change:  1 + 5    = 6
> 5th change:  6 + (-6) = 0
> 6th change:  0 + 1    = 1
> 
> max(0, 3, -1, 1, 6, 0, 1) = 6
> ```
>
> **Example 4**
>
> ```text
> Input: @gain = (-1, -2, -3, -4)
> Output: 0
> 
> start: 0
> 1st change:  0 + (-1) = -1
> 2nd change: -1 + (-2) = -3
> 3rd change: -3 + (-3) = -6
> 4th change: -6 + (-4) = -10
> 
> max(0, -1, -3, -6, -10) = 0
> ```
>
> **Example 5**
>
> ```text
> Input: @gain = (-10, 15, 5)
> Output: 10
> 
> start: 0
> 1st change:   0 + (-10) = -10
> 2nd change: -10 + 15    = 5
> 3rd change:   5 + 5     = 10
> 
> max(0, -10, 5, 10) = 10
> ```

If the first task took me quite a bit of effort, the second task was really easy.

I use `reductions` to compute the running sum of the input numbers, and with `reductions` returning all intermediate results, these intermediate results happen to be the altitudes that we want to get the maximum of.

So the task can be solved in a single line:

```perl
use v5.36;
use List::Util qw( reductions max );

sub peak_point( @gain ) {
    return max( reductions { $a + $b } 0, @gain );
}
```

#### **Thank you for the challenge!**
