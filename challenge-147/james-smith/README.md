[< Previous 146](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-146/james-smith) |
[Next 148 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-148/james-smith)
# Perl Weekly Challenge #147

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-147/james-smith

# Challenge 1 - Truncatable Prime

***Write a script to generate first 20 left-truncatable prime numbers in base 10. In number theory, a left-truncatable prime is a prime number which, in a given base, contains no 0, and if the leading left digit is successively removed, then all resulting numbers are primes.***

## The solution

Another prime problem this week so we can reuse our generator from last week...

```perl
for(;;$c+=2){
  ($_*$_>$c)?((push@p,$c),last):$c%$_||last for@p;
}
```

We are asked to find the first 20 left-truncatable primes. Primes which when you repeatedly remove the first digit you get another prime.

The naïve approach is to loop through all numbers and the check that any prime found has this property. Well this works OK for `N = 20`, but what if `N = 100` or `N = 1000` or larger. This approach doesn't scale well.

So how can we resolve this. We note that for left-truncatable prime of length `n+1` is a prime, whose first digit is one of `1 .. 9`, and the remaining digits are a left-truncatable prime of length `n`.

This means we can create a series of left-truncatable primes of a given length, by using the short left-truncatable primes. This may slow down things when `n` is small - but it greatly reduces the search space as `n` increases.

We still need to keep a list of all prime numbers, but only up to the square root of the left-truncatable prime. Greatly reducing the number we have to find/store.

Now there are 4,260 such numbers the largest having 24 digits: 357,686,312,646,216,567,629,137. The code works up until left-truncatable prime 4,241 - as this is the largest l-truncatable prime less than `2^63` the largest 64-bit unsigned integer. It took about 15.5 hours to generate this list.

```perl
## Set up primes
my( $TEMPLATE, $t0, $index, $N, $c, @primes ) =
  ( "%6d\t%28d\t%15.6f\n", time, 0, @ARGV ? $ARGV[0] : 20, 5, 3 );
my @tprimes_current = (3,7);

printf $TEMPLATE, ++$index, $_, time-$t0 for 2,3,5,7;
while(1) {
  # ** Stop if there are no primes of length `n`.
  @tprimes_current||last;
  my @tprimes_new = ();
  # ** Loop through each of possible left-truncatable primes...
  for my $first ( 1..9 ) {
    B: for my $base ( @tprimes_current ) {
      # ** New left-truncated prime candidate.
      my $p = $first.$base;
      # ** Use our prime generator this stopping when we have enough
      #    primes - to sqrt of left-truncatable prime.
      for( ;$primes[-1]*$primes[-1]<$p;$c+=2) {
        ($_*$_>$c)?(push(@primes,$c),last):$c%$_||last for @primes;
      }
      # ** See if left-truncatable prime is prime...
      $p%$_||next B for @primes;
      push @tprimes_new, $p;
      printf $TEMPLATE, ++$index, $p, time - $t0;
      exit if $index >= $N;
    }
  }
  ## Replace current list with new list for the next loop round.
  @tprimes_current = @tprimes_new;
}
```

### Notes:

 * As we are printing out the truncatable primes we don't keep a record of them, only the list of length `n` (`@tprimes_current`) and those of length `n+1` (`@tprimes_new`).
 * Although primes of length 1 can end in `2` and `5`, all other left-truncatable primes end in `3` or `7`. So we initialise `@tprimes_current` with 2 values `3` and `7`.
 * We know the number of left-truncatable primes as there are no 25 digit left-truncatable primes...
 * We use the label version of `next` - `next B` to jump out of the loop through the primes and also the inner loop ( `@tprimes_current` ).

### Results..

There are 4260 left-truncatable primes - 4241 are less than the max integer value in perl (2^63) - and takes about 15.5 hours.

```
     1                                   2           0.000006
     2                                   3           0.000467
     3                                   5           0.000721
     4                                   7           0.000930
     5                                  13           0.000025
...
...
...
  4238           6,918,997,653,319,693,967       46025.573958
  4239           7,986,315,421,273,233,617       50835.182091
  4240           8,918,997,653,319,693,967       54882.080819
  4241           8,963,315,421,273,233,617       55078.314226
```
## Aside - Right-truncatable primes

We can modify our script slightly to handle right truncatable primes - this is actually a simpler problem to the left truncatable primes, as there is a lot less of them, as they all have the form `[2357][1379]*`. Obviously we have to modify the code to add the extra digit at the end of the number rather than at the front but we also have to switch the order of the two for loops. Rather than the outer one being the digit added and the inner one the list of truncatable primes of length `n-1` we have to make the outer loop as the list of right truncatable primes and the inner loop the additional digits - there are only 4 options here 1, 3, 7 & 9. This ensures the primes come out in numerical order.

```perl
my ( $TEMPLATE, $idx, $t0, $c, @primes ) =
   ( "%6d\t%28d\t%15.6f\n", 0, time, 5, 3 );
my @tprimes_current = (2,3,5,7);
printf $TEMPLATE, ++$idx, $_, time - $t0 foreach @tprimes_current;

for my $p ( 1 .. 100 ) {
  @tprimes_current||last;
  my @tprimes_new = ();
  foreach my $base ( @tprimes_current ) {
    B: foreach my $last ( 1,3,7,9 ) {
      my $n = $base.$last;
      foreach( ;$primes[-1]*$primes[-1]<$n;$c+=2) {
        ($_*$_>$c)?(push(@primes,$c),last):$c%$_||last for @primes;
      }
      $n%$_||next B foreach @primes;
      push @tprimes_new, $n;
      printf $TEMPLATE, ++$idx, $n, time - $t0;
    }
  }
  @tprimes_current = @tprimes_new;
}
```

### Results..

There are 83 right-truncatable primes - the script runs for less than 0.02 seconds.

```
     1                               2           0.000006
     2                               3           0.000467
     3                               5           0.000721
     4                               7           0.000930
     5                              23           0.001119
...
...
...
    81                      37,337,999           0.011444
    82                      59,393,339           0.012381
    83                      73,939,133           0.013005
```

# Challenge 2 - Pentagon Numbers

***Write a sript to find the first pair of Pentagon Numbers whose sum and difference are also a Pentagon Number. A pentagon number has the form: `P(n) = n(3n - 1)/2`***

## The solution

We create an array of pentagon numbers, along with a map from value to key. The while loop makes sure that we have enough pentagonal numbers to be greater than the sum of the two pentagonal numbers (indexed by by `$o` and `$i`).

 
```perl
my %q = map { $_=>$_ } (my @p = (0,1)); #1
for(my $o=2;;$o++) {
  for(my $i=1, ($q{$p[$o]||=$o*(3*$o-1)/2}||=$o); $i<$o; $i++) { #2
    (my $d=$q{$p[$o]-$p[$i]}) || next;                           #3
    (push(@p, @p * (3*@p-1)/2), $q{$p[-1]}=@p) while $p[$o]+$p[$i] > $p[-1];  #4
    (my $s=$q{$p[$o]+$p[$i]}) || next;                           #5
    die "First 2 pents are:\n  p($o) = $p[$o]\n  p($i) = $p[$i],\n  p($o) + p($i) = $p[$s] = p($s),\n  p($o) - p($i) = $p[$d] = p($d).\n" #6
  }
}
```
### The result

The output of the script is:
```
First 2 pents are:
  p(2167) = 7042750
  p(1020) = 1560090,
  p(2167) + p(1020) = 8610026 = p(2396),
  p(2167) - p(1020) = 5488397 = p(1913).
```

### Notes:
 * #1 - initialise the map of pentagonal numbers.
 * #2 - make sure that the next entry in the pentagonal numbers is present
 * #3 - try next combination if the difference is not a pentagonal number
 * #4 - extend pentagonal number list so that it contains all pentagonal numbers up to and including the sum of the two pentagonal numbers.
 * #5 - try next combination if the sum is not a pentagonal number
 * #6 - we display the summary information about the pentagonal numbers

## Expanded solution.

For those that want this a bit more expanded this is the same code expanded out. 

```perl
my @pents     = ( 0, 1 );
my %rev_pents = ( 0 => 0, 1 => 1 );

for( my $o=2; ; $o++ ) {
  $pents[$o]               ||= $o * (3 * $o - 1 ) / 2;
  $rev_pents{ $pents[$o] } ||= $o;
  for my $i ( 1 .. $o-1 ) {
    next unless my $diff_idx = $rev_pents{ $pents[$o] - $pents[$i] };
    while( $pents[-1] < $pents[$o] + $pents[$i] ) {
      push @pents, @pents * ( 3 * @pents - 1 ) / 2;
      $rev_pents{ $pents[-1] } = @pents;
    }
    next unless my $sum_idx  = $rev_pents{ $pents[$o] + $pents[$i] };
    say 'First 2 pents are:';
    say '  p($i) = $pents[$i],';
    say '  p($o) = $pents[$o],';
    say '  p($o) + p($i) = $pents[$sum_idx] = p($sum_idx),';
    say '  p($o) - p($i) = $pents[$diff_idx] = p($diff_idx).';
    exit;
  }
}
```
