[< Previous 155](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-155/james-smith) |
[Next 157 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-157/james-smith)
# The Weekly Challenge #156

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-156/james-smith

# Challenge 1 - Pernicious Numbers

***Write a script to permute first 10 Pernicious Numbers. - A pernicious number is a positive integer which has prime number of ones in its binary representation.***

## The solution

```perl
my %primes = map { $_ => 1 } 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37;

my $n=0;

$n++, exists $primes{(sprintf '%b', $n)=~tr/1/1/} ? (say $n) : redo for 1..10;
```

Expanding out the `for` loop we have the slightly more readable code:

```perl
my $n = 0;
for (1..10) {
  $n++;
  redo unless exists $primes{(sprintf '%b', $n)=~tr/1/1/};
  say $n;
}
```

# Challenge 2 - Weird numbers

***You are given number, $n > 0. Write a script to find out if the given number is a Weird Number - a number for which the sum of the proper divisors (divisors including 1 but not itself) of the number is greater than the number, but no subset of those divisors sums to the number itself.***

## The solution

```perl
sub is_weird {
  my($s,$n) = (0,shift);

  $s+=$_ for my @fact = (1,map { $n%$_ ? () : ( $_, $_*$_==$n ? () : $n/$_ ) } 2..sqrt($n));

  return 0 if $s <= $n;

  for my $ind ( 0..(1<<@fact) ) {
    my $t = -$n;
    ($ind & 1 && ($t+=$fact[$_]) ),$ind>>=1 for 0..$#fact;
    return 0 unless $t;
  }

  return 1;             ## Weird
}
```

