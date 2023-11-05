# Rewriting the Rules Can Make Things Simple
**Challenge 241 solutions in Perl by Matthias Muth**

## Task 1: Arithmetic Triplets

> You are given an array (3 or more members) of integers in increasing order and a positive integer.<br/>
> Write a script to find out the number of unique Arithmetic Triplets satisfying the following rules:<br/>
> a) i < j < k<br/>
> b) nums[j] - nums[i] == diff<br/>
> c) nums[k] - nums[j] == diff<br/>
> <br/>
> Example 1<br/>
> Input: @nums = (0, 1, 4, 6, 7, 10)<br/>
>     \$diff = 3<br/>
> Output: 2<br/>
> Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.<br/>
> Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.<br/>
> <br/>
> Example 2<br/>
> Input: @nums = (4, 5, 6, 7, 8, 9)<br/>
>     \$diff = 2<br/>
> Output: 2<br/>
> (0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.<br/>
> (1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.<br/>

The way the task description is written might lead us to a solution where we create all  possible triplets, and then check for each of them whether the three numbers fulfill  the 'diff' criteria. So actually we would need to solve a permutation task, with all its typical caveats, like the number of permutations running away too easily, and the high order of complexity in general. 

But we can restate the task in a different way and find a much simpler way to solve it:<br/>
Instead of 

> Write a script to find out the number of unique Arithmetic Triplets satisfying the following rules:<br/>
> a) i < j < k<br/>
> b) nums[j] - nums[i] == diff<br/>
> c) nums[k] - nums[j] == diff<br/>

we formulate:
> Write a script to find out how many numbers nums[i] exist in the array where<br/>
> a) nums[i] + diff also exists in the array,<br/>
> b) nums[i] + 2 * diff also exists in the array.

That sounds much better!

What we need to do is to create a hash lookup for checking the existence of the values in the array.
Here we go:

```perl
    my %nums = map { ( $_ => 1 ) } @nums;
```
Using this lookup, it's easy to filter out those numbers of the array
for which the '+ diff' and '+ 2 * diff' values also exist.
We use `grep` for that.
And it's also easy to get the number of hits instead of the hits themselves by just using `grep` in a scalar context:

```perl
    return scalar grep
        exists $nums{ $_ + $diff } && exists $nums{ $_ + 2 * $diff },
        @nums;
```
As we have more than one parameter to call the function with (the `@nums` array and the `$diff` scalar value),
we pass in the `@nums` array as an array reference. We create a real array immediately after entering our subroutine (only for easier reading!).<br/>
This makes my  final solution look like this:

```perl
sub arithmetic_triplets( $nums_aref, $diff ) {
    # Copy the array ref into a local array (only for easier reading).
    my @nums = $nums_aref->@*;
    # Create a lookup for all numbers.
    my %nums = map { ( $_ => 1 ) } @nums;
    # Return the number of numbers fulfilling the criteria.
    return scalar grep
        exists $nums{ $_ + $diff } && exists $nums{ $_ + 2 * $diff },
        @nums;
}
```
Good to avoid the permutations like that!

## Task 2: Prime Order

> You are given an array of unique positive integers greater than 2.<br/>
> Write a script to sort them in ascending order of the count of their prime factors, tie-breaking by ascending value.<br/>
> <br/>
> Example 1<br/>
> Input: @int = (11, 8, 27, 4)<br/>
> Output: (11, 4, 8, 27))<br/>
> Prime factors of 11 => 11<br/>
> Prime factors of  4 => 2, 2<br/>
> Prime factors of  8 => 2, 2, 2<br/>
> Prime factors of 27 => 3, 3, 3<br/>

In a first step, we create an array that contains the number of prime factors for each number in `@int` at the same index.
This will make it easier for sorting the numbers later on.

I separated out the computation of the number of prime factors for a given number `$n`  into an own function.
It walks through the possible factors for `$n` (not overly optimized; actually it tries every number, wheras trying only prime numbers would be enough). If the number is divisible by that factor without rest, it divides that factor away, increases the number of factors, and tries the same factor again before moving on.<br/>
Like this:     

```perl
sub n_prime_factors( $n ) {
    my $n_prime_factors = 0;
    for ( my $i = 2; $i <= $n; ++$i ) {
        if ( $n % $i == 0 ) {
            $n /= $i;
            ++$n_prime_factors;
            redo;
        }
    }
    return $n_prime_factors;
}
```

The complete solution first generates the number of prime factors for all numbers in the `@int` array,
using the function just described. 

It then returns the `@int` numbers in the order determined by `sort` with a code block. Instead of using a temporary array and sorting it, the sorted numbers are returned directly from the original array, using Perl's array slice syntax. This works well with the `sort` code block that uses the same array indexes to access the number of prime factors as well as the numbers themselves in case of a tie. 

```perl
sub prime_order( @int ) {
    my @n_prime_factors = map n_prime_factors( $_ ), @int;
    return @int[
        sort {
            $n_prime_factors[$a] <=> $n_prime_factors[$b]
                || $int[$a] <=> $int[$b]
        } 0..$#int
    ];
}
```

I think Perl helps a lot to keep these solutions short and fun, but still readable.  

#### **Thank you for the challenge!**
