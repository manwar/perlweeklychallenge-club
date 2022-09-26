[< Previous 176](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-176/james-smith) |
[Next 178 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-178/james-smith)

# The Weekly Challenge 177

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-177/james-smith

# Task 1 - Damm Algorithm

***You are given a positive number, `$n`.  Write a script to validate the given number against the included check digit.***

The wikipedia page outlines the algoritm: https://en.wikipedia.org/wiki/Damm_algorithm

## Algorithm

We have a 10x10 lookup table - each row contains the numbers 0..9 permuted.

We break the numbers up in to digits, and loop through them one at a time computing the subsequent check digit. We start with a check digit of `$d=0`.
For each digit `$n` we take the value of the `$d` row and `$n` column and assign this to `$d`.

If we are checking a contained check digit then at the end of the loop the value should be `0`. If not then we have just computed the check digit.

## Solution

```perl
const my @M => (
  [0,3,1,7,5,9,8,6,4,2],
  [7,0,9,2,1,5,4,8,6,3],
  [4,2,0,6,8,7,1,3,5,9],
  [1,7,5,0,9,8,3,4,2,6],
  [6,1,2,3,0,4,5,9,7,8],
  [3,6,7,4,2,0,9,5,8,1],
  [5,8,6,9,7,2,0,1,3,4],
  [8,9,4,5,3,6,2,0,1,7],
  [9,4,3,8,6,1,7,2,0,5],
  [2,5,8,1,4,3,6,7,9,0],
);

sub check_damm { my $i=0; $i=$M[$i][$_] for split//,pop; $i?0:1; }
sub damm_digit { my $i=0; $i=$M[$i][$_] for split//,pop; $i;     }
```

# Task 2 - Palindromic Prime Cyclops

***Write a script to generate palindromic cyclops primes***

 * Palindromic - reads the same forward and back
 * Cyclops - odd number of digits - central digit is 0
 * Prime - only factors are 1 and itself.

## Solution

There are two approaches:

 * Generate a list of palindromic cyclops numbers, check if any are prime
 * Generate a list of prime numbers, and check if any are palindromic cyclops numbers.

But which one is best. Now say we have to generate the list of these numbers up 1 billion. So these are numbers of the form:

```
  a b c, d 0 d, c b a
```

So if we generate the list of palindromic cyclops numbers we just need to generate all numbers from `1..9,999`, if we generate all primes in this range there are `50,847,534`, this is `5,085x` factor more.

Which suggest the first algorithm will be faster - to make this generic we change include a variable count `$K` for the number of entries to return.

```perl
my($i,$t)=0;

for(1..$K) {
  ($++$i)!~/0/ && is_prime( $t = $i.'0'.reverse$i ) ? say $t : redo;
}
```

In fact this is efficient enough to get the first 1,000,000 such numbers back in slightly under 10 seconds. The millionth one being the 17 digit number: `76,276,363,036,367,267`.

But we can get better performance as we are currently scanning all numbers which start with 2,4,5,6,8 which we know are not prime {first digit -> last digit!} - this leads us to a slightly more complex but faster piece of code:

Reducing to numbers that start in 1,3,7,9 reduces the search space by a factor of 4/9.

By removing those that line between say 100... and 111... which must contain at least one zero further reduces this by 8/9 - giving us a reduction of 32/81 numbers or roughly 39.5%.

```perl
my( $magnitude, $ones, $start, $count,       $result ) =
  (          1,     0,   time, $ARGV[0]//20, '-'     );
O: while(1) {
  for my $first (1,3,7,9) {
    !/0/ && is_prime( $_ .= '0' . reverse $_ ) &&
    say  && ( --$count || ( $result = $_ ) && last O )
      for $first * $magnitude + $ones .. ( $first + 1 ) * $magnitude - 1;
  }
  $magnitude *= 10;
  $ones      *= 10;
  $ones++;
}
warn time-$start, "\t", $result, "\n";
```

Where we scan from 111.. to 199.., 311.. to 399.., 711.. to 799.., 911.. to 999...

With this new version of the code we get this 1,000,000 entry coming back in around 10 seconds. Running a bit longer gives the 10,000,000th entry in a little over 2 minutes.

| $K          | Time v1    | Time v2    | $Kth value                |
| ----------: | ---------: | ---------: | ------------------------: |
|           1 |   0.000018 |   0.000018 |                       101 |
|          10 |   0.000056 |   0.000039 |                 1,120,211 |
|         100 |   0.000498 |   0.000309 |               146,505,641 |
|       1,000 |   0.006829 |   0.004846 |            19,178,087,191 |
|      10,000 |   0.114116 |   0.064679 |         3,446,840,486,443 |
|     100,000 |   1.286905 |   0.787072 |       387,695,909,596,783 |
|   1,000,000 |  23.104720 |   9.993216 |    76,276,363,036,367,267 |
|  10,000,000 | 250.055394 | 124.405436 | 9,523,518,610,168,153,259 |

Flipping to use `Math::Perl::Util::GMP` and `is_provable_prime` we can get a "guess" at even longer entries. "Guess" because the `is_provable_prime` can return NO, YES or probably, as there is compromise between accuracy and performance when it comes to checking these large primes. So for 100 million and 1 billion we get the following answers and timings. The latter being a smidge under 21 hours.

| $K            | Time v1    | Time v2    | $Kth value                        | Time                |
| ------------: | ---------: | ---------: | --------------------------------: | ------------------: |
|   100,000,000 |          - |   6370.062 |    11,459,314,276,067,241,395,411 |  1 hr 46 min 10 sec |
| 1,000,000,000 |          - |  75584.858 | 1,255,854,925,630,365,294,585,521 | 20 hr 59 min 45 sec |

