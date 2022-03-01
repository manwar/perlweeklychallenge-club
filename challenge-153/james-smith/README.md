[< Previous 152](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-152/james-smith) |
[Next 154 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-154/james-smith)
# The Weekly Challenge #153

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-153/james-smith

# Challenge 1 - Triangle Sum Path

***Write a script to compute Left Factorials of 1 to 10. It is the sum of all the factorials upto `n`***

## Solution

This is quite an easy caclulation - the `n+1`st left factorial is equal to the `n`nth left factorial + `n!`

Leading us to:

```perl
say my $t = $f = 1;
say $t += ($f*=$_) for 1..20;
```

to write out the first 21 (the largest number that can be represented as a an integer in 64bit perl) rather than 10.

To get a better formatted output we can run the slightly more verbose script:

```perl
printf "%26s\n", my $t = my $f = 1;
printf "%26s\n", scalar reverse ( reverse ($t+=($f*=$_)) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) for 1..20;
```

Which gives the following output...

| *n* | *!n* - Left factorial     |
| --: | ------------------------: |
|   0 |                         0 |
|   1 |                         1 |
|   2 |                         2 |
|   3 |                         4 |
|   4 |                        10 |
|   5 |                        34 |
|   6 |                       154 |
|   7 |                       874 |
|   8 |                     5,914 |
|   9 |                    46,234 |
|  10 |                   409,114 |
|  11 |                 4,037,914 |
|  12 |                43,954,714 |
|  13 |               522,956,314 |
|  14 |             6,749,977,114 |
|  15 |            93,928,268,314 |
|  16 |         1,401,602,636,314 |
|  17 |        22,324,392,524,314 |
|  18 |       378,011,820,620,314 |
|  19 |     6,780,385,526,348,314 |
|  20 |   128,425,485,935,180,314 |
|  21 | 2,561,327,494,111,820,314 |

# Challange 2 - Factorions

***You are given an integer, `$n`. Write a script to figure out if the given integer is factorion. A factorion is a natural number that equals the sum of the factorials of its digits.***

## Some notes

Firstly we need to note that (in base 10) that the largest Factorion would have at most 7 digits. For
a given number of digits (m) the largest value of the sum of the digits is `9! x m` or `362,880 x m`.
For `m=7` we have the largest value being `2,540,160` which has 7-digits, for `m=8` we note that this
value `2,903,040` also has 7 digits - so we can't have a solution with 8 or more digits.

So we only need to loop up to `2,540,160` - in fact we can reduce this further as for the 7-digit
numbers they will either start with 1 or 2. So we can further reduce this to `2 + 6 * 9!` or
`2,177,282`.

## Solution

Our is factorion function just adds the factorial digit sum and compares to the number itself.

We start with a pre-computed list of factorials as we only need the values for the integers 0..9;

To avoid having to do a comparison at the end, rather than starting at zero we start at `$n`,
so the comparison at the end is just whether or not the sum is `0`.

```perl
my @f = (1);
push @f, $_*$f[-1] foreach 1 .. 9;

is_factorion($_) && say for 1 .. 2_177_282;

sub is_factorion {
  my $t = $_[0];
  ($t-=$f[$_])||return 1 for split //,$t;
  return 0;
}
```

Running this gives the only 4 factorions: `1`, `2`, `145`, `40585`;

This takes around 3 seconds to run on my test box. To speed this up we can
work with groups of up to 4 digits - so we first create the sum arrays for
1, 2, 3 and 4 digits. Note the sum for `20` is different to the sum from
`0020` - as `0! = 1`.

The code then becomes:

```perl
my @f = (1);
push @f, $_*$f[-1] foreach 1 .. 9;

my @z = map { my $t = $_; map {$t+$_} @f } 
my @q = map { my $t = $_; map {$t+$_} @f } 
my @t = map { my $t = $_; map {$t+$_} @f } @f;

is_factorion_10k($_) && say for 1 .. 2_177_282;

sub is_factorion_10k {
  my $t = $_[0];
  return $t == (
      $t >= 1e6 ? $z[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e5 ? $q[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e4 ? $t[ $t/1e3 ] + $q[ $t%1e3 ]
    : $t >= 1e3 ?                $z[ $t     ]
    : $t >= 100 ?                $q[ $t     ]
    : $t >=  10 ?                $t[ $t     ]
    :                            $f[ $t     ]
  );
}
```

This comes in at just less than 1 second - a `4x` speed up. Note the order of the
ternaries is important - we start from highest to lowest as it minimizes the
average number of comparisions performed.
