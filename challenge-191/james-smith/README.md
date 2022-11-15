[< Previous 189](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-189/james-smith) |
[Next 191 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-191/james-smith)

# The Weekly Challenge 190

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-190/james-smith

# Task 1 - Twice Largest

***You are given list of integers, `@list`. Write a script to find out whether the largest item in the list is at least twice as large as each of the other items.***

## Solution

We can simplify the condition to that the largest number is at least twice the value of the second largest number.

Our naive approach could be to sort the numbers and check `$list[-1] >= 2*$list[-2]`.

But this isn't efficient if the list is large - instead we will just track the two largest numbers.

 * We grab the first two numbers, and store the largest one in $f and the other one in $s.
 * For each other number ($_):
   * $_ <= $s - ignore do nothing
   * $s < $_ && $_ <= $f - replace 2nd number $s with $_
   * $f < $_ - replace 2nd number $s with $f, and replace $f with $_
 * Return is based on whether `$f >= 2*$s`

```perl
sub is_double {
  my( $f, $s ) = ( shift, shift );           # First two numbers
  ( $f, $s ) = ( $s, $f ) if $f < $s;        # Switch if 1st < 2nd
  $_>$f ? ( ( $f, $s ) = ( $_, $f ) )        # For each number
        : ( $_ > $s && ( $s = $_ ) ) for @_; #   if > 1st
                                             #     demote 1st to 2nd
                                             #     replace 1st
                                             #   if > 2nd
                                             #     demote 2nd
  $f >= 2*$s ? 1 : -1                        # Check condition
}
```
# Task 2 - Cute List

***You are given an integer, `0 < $n <= 15`. Write a script to find the number of orderings of numbers that form a cute list.***

***With an input `@list = (1, 2, 3, .. $n)` for positive integer `$n`, an ordering of `@list` is cute if for every entry, indexed with a base of 1, either:***

 * ***`$list[$i]` is evenly divisible by `$i`***
 * ***`$i` is evenly divisible by `$list[$i]`***

## Solution

Again this weeks task 2 is a much more interesting challenge. And has a number of different approaches we can find.

 * Do we use recursion - or - interation?
 * Do we memoize or not? if so what key do we use?
 * Are there any simple optimizations - how to make the loop fail earlier?

Firstly - we could use permutations - but this screams out initially at least for recursion.

Before we start some observations:

 * We can pre-compute which numbers can be at which position to give us an array like:

   * `[1,2,3,4,5,6,7]`, `[1,2,4,6]`, `[1,3,6]`, `[1,2,4]`, `[1,5]`, `[1,2,3,6]`, `[1,7]`

 * When we search we can re-order the lists to fill in numbers from the short lists first

   * `[1,5]`, `[1,7]`, `[1,3,6]`, `[1,2,4]`, `[1,2,4,6]`, `[1,2,3,6]`, `[1,2,3,4,5,6,7]`

 * Our keys are all integers and less than 64. We can therefore use a bit mask as the keys
   for the cache...

   Already placed `2`, `4`, `7` they key would be `10010100`

These observations lead us to:
```perl
my %cache;

sub cute {
  %cache=(); ## Reset the count...
  _cute_count( 0,
      ## Return the list of values at a give index
    map  { $_->[1] }
      ## sort these lists into an array based on length of list and position
    sort { @{$a->[1]} <=> @{$b->[1]} || $a->[0] <=> $b->[0] }
      ## compute the list of numbers which are either factor or multiple
    map { $a=$_; [ $a => [ grep { ! ( $_%$a && $a%$_ ) } 1 .. $_[0] ] ] }
      ## for each position
    1 .. $_[0]
  );
}

sub _cute_count {
  my( $seen, $next ) = ( shift, shift );
  ## Now do the cute counting... if the length of the array is 1 then we know this is one response
  ## and it will be valid - so return 1;
  ## o/w we sum the counts of child elements
  @_ ? $cache{$seen} //= sum0 map { ($seen & 1<<$_) ? 0 : _cute_count( $seen | 1<<$_ , @_ ) } @{$next}
     : 1;
}
```
### Performance

We compared this algorithm with various ones with ordering and without we have the following timings:

| Method                      | Rate    | Gain |
| :-------------------------- | ------: | ---: |
| No-cache, no-ordering trick |  1.19/s |      |
| No-cache, ordering trick    |  7.29/s |   6x |
| Cache, no-ordering trick    |  17.4/s |  15x |
| Cache, ordering trick       |  97.0/s |  80x |

### Timings for increasing `$N`

The original challenge asked us to compute values up to `n=15` - the cumulative time for this is between 1.05 and 1.30 seconds. We can continue on to `n=30` taking around 19 seconds.

The script finally crashes after `n=39` (with a count of around 5.5 trillion) - when the cache memory usage exceeds 7GBytes (the capacity of the machine) and starts to swap.

| ind |             Count | Time loop  | Cumul time |
| --: | ----------------: | ---------: | ---------: |
|   1 |                 1 |   0.000010 |   0.000011 |
|   2 |                 2 |   0.000018 |   0.000076 |
|   3 |                 3 |   0.000016 |   0.000105 |
|   4 |                 8 |   0.000022 |   0.000136 |
|   5 |                10 |   0.000028 |   0.000175 |
|   6 |                36 |   0.000067 |   0.000251 |
|   7 |                41 |   0.000085 |   0.000346 |
|   8 |               132 |   0.000177 |   0.000533 |
|   9 |               250 |   0.000241 |   0.000790 |
|  10 |               700 |   0.000493 |   0.001299 |
|  11 |               750 |   0.000601 |   0.001916 |
|  12 |             4,010 |   0.001535 |   0.003466 |
|  13 |             4,237 |   0.001722 |   0.005206 |
|  14 |            10,680 |   0.002893 |   0.008116 |
|  15 |            24,679 |   0.005721 |   0.013854 |
|  16 |            87,328 |   0.009010 |   0.022884 |
|  17 |            90,478 |   0.010208 |   0.033113 |
|  18 |           435,812 |   0.020486 |   0.053620 |
|  19 |           449,586 |   0.023270 |   0.076913 |
|  20 |         1,939,684 |   0.078741 |   0.155676 |
|  21 |         3,853,278 |   0.125847 |   0.281549 |
|  22 |         8,650,900 |   0.173449 |   0.455045 |
|  23 |         8,840,110 |   0.224917 |   0.680006 |
|  24 |        60,035,322 |   0.359825 |   1.039877 |
|  25 |        80,605,209 |   0.511679 |   1.551599 |
|  26 |       177,211,024 |   0.663506 |   2.215148 |
|  27 |       368,759,752 |   1.033414 |   3.248616 |
|  28 |     1,380,348,224 |   2.533999 |   5.782659 |
|  29 |     1,401,414,640 |   2.951694 |   8.734403 |
|  30 |     8,892,787,136 |  10.241124 |  18.975582 |
|  31 |     9,014,369,784 |  11.076978 |  30.052606 |
|  32 |    33,923,638,848 |  13.505877 |  43.558524 |
|  33 |    59,455,553,072 |  20.499038 |  64.057609 |
|  34 |   126,536,289,568 |  23.903329 |  87.960986 |
|  35 |   207,587,882,368 |  57.064045 | 145.025074 |
|  36 | 1,495,526,775,088 |  99.565625 | 244.590748 |
|  37 | 1,510,769,105,288 | 109.442520 | 354.033321 |
|  38 | 3,187,980,614,208 | 134.032712 | 488.066089 |
|  39 | 5,415,462,995,568 | 175.846131 | 663.912274 |
