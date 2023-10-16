# Reduced Arrays, Reduced Numbers, Reduced Code

**Challenge 238 solutions in Perl by Matthias Muth**

This week's challenges seem to be all about '*reducing*' things.

My solution for Task 1 uses the `reductions` function from the `List::Util` core module.<br/>Actually this *reduces* the code to one single statement.

And in Task 2 we have to *reduce* numbers to their
'[multiplicative digital root](https://en.wikipedia.org/wiki/Multiplicative_digital_root)'
before sorting them.<br/>My solution then also *reduces* the runtime by caching those *reduced* numbers.

So here is an  *'unreduced'* description of my *'reduced*' solutions. :-)

## Task 1: Running Sum

> You are given an array of integers.<br/>
> Write a script to return the running sum of the given array. The running sum can be calculated as $$sum[i] = num[0] + num[1] + …. + num[i]$$.<br/>
> <br/>
> Example 1<br/>
> Input: @int = (1, 2, 3, 4, 5)<br/>
> Output: (1, 3, 6, 10, 15)<br/>
> <br/>
> Example 2<br/>
> Input: @int = (1, 1, 1, 1, 1)<br/>
> Output: (1, 2, 3, 4, 5)<br/>
> <br/>
> Example 3<br/>
> Input: @int = (0, -1, 1, 2)<br/>
> Output: (0, -1, 0, 2)<br/>

A 'running sum' is a good example for what the `reduce`function and its close relative `reductions` can do.<br/>

From the `List::Util` [docs](https://perldoc.perl.org/List::Util#reduce):

>```perl
>$result = reduce { BLOCK } @list
>```
>Reduces `@list` by calling `BLOCK` in a scalar context multiple times, setting `$a` and `$b` each time. The first call will be with `$a` and `$b` set to the first two elements of the list, subsequent calls will be done by setting `$a` to the result of the previous call and `$b` to the next element in the list.<br/>Returns the result of the last call to the `BLOCK`. [...]
>
>```perl
>@results = reductions { BLOCK } @list
>```
>
>Similar to `reduce` except that it also returns the intermediate values along with the final result.<br/>The returned list will begin with the initial value for `$a`, followed by each return value from the block in order. The final value of the result will be identical to what the `reduce` function would have returned given the same block and list.

The `sum` function is nothing but a specialization of `reduce`, and it can be implemented like this:
```perl
sub sum( @list ) {
    return reduce { $a + $b } @list;
}
```
So we can use `reduce` for summing up the list elements from the first to the last.<br/>
And if we use `reductions` instead, we also get all the intermediate results, which are exactly the

> $$    num[i] = num[0] + num[1] + …. + num[i]$$

that we need to return as the result:

```perl 
use List::Util qw( reductions );
sub running_sum( @int ) {
    return reductions { $a + $b } @int;
}
```

This is almost *less* than a one-liner! :-)

## Task 2: Persistence Sort

> You are given an array of positive integers.<br/>
> Write a script to sort the given array in increasing order with respect to the count of steps required to obtain a single-digit number by multiplying its digits recursively for each array element. If any two numbers have the same count of steps, then print the smaller number first.<br/>
> <br/>
> Example 1<br/>
> Input: @int = (15, 99, 1, 34)<br/>
> Output: (1, 15, 34, 99)<br/>
> 15 => 1 x 5 => 5 (1 step)<br/>
> 99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)<br/>
> 1  => 0 step<br/>
> 34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)<br/>
> <br/>
> Example 2<br/>
> Input: @int = (50, 25, 33, 22)<br/>
> Output: (22, 33, 50, 25)<br/>
> 50 => 5 x 0 => 0 (1 step)<br/>
> 25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)<br/>
> 33 => 3 x 3 => 6 (1 step)<br/>
> 22 => 2 x 2 => 4 (1 step)<br/>

So we need the number of steps needed for reducing each number to its single digit '[multiplicative digital root](https://en.wikipedia.org/wiki/Multiplicative_digital_root)'. Let's create a function for computing that. It contains a counter and a loop that reduces the number as long the result has more than one digit. 

For doing the actual reduction, I use `split` to separate the digits of the number, and `product` from the `List::Util` core module to multiply them with each other. Perl makes it easy to change between strings and numbers without effort.

```perl
use List::Util qw( product );
sub steps_needed( $n ) {
    my $n_steps = 0;
    while ( $n > 9 ) {
        ++$n_steps;
        $n = product( split "", $n );
    }
    return $n_steps;
}
```

Next, I use a hash for storing the number of steps for each number in the list.<br/>
I use a hash, not an array, because we don't know how big the numbers in the original list can get.<br/>
This hash will then be used in sorting the list.

Perl's `sort` makes it easy to implement more complicated sorting criteria or combinations of criteria as in this case. The code block that is passed to sort compares the number of steps first, and next the numbers themselves in case that the former are equal.

The result of the `sort` can directly be returned as the result.

```perl
sub persistence_sort( @int ) {
     my %steps = map { ( $_, steps_needed( $_ ) ) } @int;
     return sort { $steps{$a} <=> $steps{$b} || $a <=> $b } @int;
}
```

Actually, I appreciate how much I learned about how functional programming concepts can *reduce* the code while doing these challenges in Perl!

#### Thank you for the challenge!

