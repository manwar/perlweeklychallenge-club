# Max Complication for Min Brute Force

# --- DRAFT Work in Progress ---

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

As usual, I try not to use brute force to solve the task. I will *not* do 'combinations', and *not* go through $\binom{n}{4} = \frac{n!}{4!(n-4)!}$ iterations to choose the right numbers.

Instead, I do will do an analysis to learn which numbers to choose.

My first observation is that for getting the largest difference, the first product has to be as big as possible, and the subtracted number has to be as low as possible. So we can change the task to

> 'Find two pairs that result in the highest possible product and the lowest possible product, respectively.'

Next observation:<br/>
The largest product can be obtained by multiplying the two largest numbers.<br/>
This should be an obvious one. But there is a huge BUT:

If we have at least two *negative* numbers in our list, and remembering that 'minus times minus equals plus', we might find that the largest (positive) product is obtained by multiplying the two *lowest* numbers (those with the largest absolute amounts).<br/>
So we have to consider the products of both the two highest positive numbers and the two lowest negative ones, and use the 'better' one.

Thus, the candidates for **the first product** are these:

* the highest two positive numbers,
* the lowest two negative numbers (resulting in a positive product).

We need to compare which one is better. If we cannot compute one or the other, we will simply use only the other one.

In any case, it will be good to separate the positive and the negative numbers into separate arrays, and have them sorted numerically, so that we can access the highest or lowest positive or negative numbers just by indexing into these arrays.

For the number to subtract, we need to find the *lowest* product possible. But this is different, because now we can be lucky and get a negative product, because negative numbers are 'low'.

So if we have negative numbers at all, we will be happy to use the lowest one available ((that was not used for the first product!), together with the highest positive number available, to get a negative product as far in the negative as possible.

So the candidates for **the second product** are these:

* if we have positive and negative numbers:<br/>
  the lowest negative number times the highest positive number,<br/>
  because this results in a number as far in the negative (or as 'low') as possible,
* if we have no negative numbers:<br/>
  the product of the lowest two positive numbers, 
* if we have no positive numbers:<br/>
  the two negative numbers closest to zero (or zero itself, if we have one). 

There are cases where the choice for the first product reduce the possible choices for the second product in a way that makes the combination of both not the best choice overall. Especially when there are only few numbers, and the choice of one product reduces the availability of numbers to choose from for the second one.

To be sure, my strategy is to try both:

* The two possible candidates for the best first product, as described above,<br/>combined with the second product chosen from what is left, for each of the candidates separately,
* the best *second* product chosen from all numbers,<br/>combined with the two possible candidates for the best *first* product from what is left.<br/>Actually we need to consider a third candidate for the first product in this case: If we used a positive and a negative number for the second product, it could be that all we have left is only a 'mixed pair' to use for the first product, something that we didn't need to consider in the cases described above for the first product.



```perl
sub max_diff() {
    ...;
}
```

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





```perl
use v5.36;
use List::Util qw( reductions max );

sub peak_point( @gain ) {
    return max( reductions { $a + $b } 0, @gain );
}
```

#### **Thank you for the challenge!**
