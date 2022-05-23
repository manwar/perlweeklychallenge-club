[< Previous 163](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-163/james-smith) |
[Next 165 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-165/james-smith)
# The Weekly Challenge 164

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-164/james-smith

# Challenge 1 - Prime Palindrome

***Write a script to find all prime numbers less than 1000, which are also palindromes in base 10. Palindromic numbers are numbers whose digits are the same in reverse. For example, 313 is a palindromic prime, but 337 is not, even though 733 (337 reversed) is also prime.***

## The solution

We use `Math::Prime::Util` and it's functions `next_prime` to loop through primes.... So the code is quite simple..

```perl
my ($p,$lim,@pal)=(1,shift//1e3);
($p ^ reverse $p) || (push @pal,$p) while ($p=next_prime $p) < $lim;
say for @pal;
```

If we don't want to store the values in `@pal` but instead just print them as generated we can simplify this to:

```perl
$_=1,my$lim=shift//1e3;
($_^reverse$_)||say while($_=next_prime$_)<$lim;
```

**Note** we use the `//` operator to set a default value `shift//1e3` sets the parameter to the first command line argument or 1000 if there is nothing passed.

# Challenge 2 - Happy Numbers

***Write a script to find the first 8 Happy Numbers in base 10.***

***Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process end in 1 are happy numbers, while those numbers that do not end in 1 are unhappy numbers.***

## Solution.

```perl
sub is_happy {
  my($n,$t,%seen) = shift;
  while($n>1) {
    return 0 if $seen{$n};
    $seen{$t=$n}=1,$n=0;
    do {$n+=($t%10)**2} while $t=int($t/10);
  }
  1;
}
```
Not much to see in this code - we loop through the function until we see the same value twice (or we get to `1`). We simply store the values seen as the keys to a hash to achieve this.

**Note:** We use `do { } until` rather than just `{ } until` as this force the block of code within the `{ }` to be executed before the check for the conditional, rather than afterwards.

### Optimized solution

If memory is no issue then you can cache the answers (happy/unhappy) for every number in the chain and if you see them for subsequent calculations you can just return that number. Obviously this requires lots of memory if you are working with lists of larger numbers....

```perl
sub happy_list_cache {
  my $count= @_ ? $_[0] : 8, my %seen, my $t, state @happy = (0,my @ret = my $N = 1);
  OUT: for (2..$count) {
    %seen=();
    my $n = ++$N;
    while($n>1) {
      last if defined $happy[$n] && $happy[$n]==1;
      if(defined $happy[$n] || $seen{$n}) { ## Unhappy no...
        $happy[$_] = 0 foreach keys %seen;
        redo OUT;
      }
      $seen{$t=$n}=1,$n=0;
      do {$n+=($t%10)**2} while $t=int($t/10);
    }
    $happy[$_]=1 for keys %seen;
    $happy[$N]=1;
    push @ret,$N;
  }
  @ret;
}
```

**Notes**

  * If you don't have unlimited memory you could consider only cacheing lower values of "happy".... for a larger value of `n` - we note that the sum of the digits is only going to be at most `81 x #digits` so you could consider only storing the first `1,539` to allow you quickly compute the happy status of all 64-bit signed integers (9,223,372,036,854,775,808) - the second iteration will always be below `1,539`...

```perl
sub happy_list_cache_limited {
  my $count= @_ ? $_[0] : 8, my %seen, my $t, state @happy = (0,my @ret = my $N = 1);
  OUT: for (2..$count) {
    %seen=();
    my $n = ++$N;
    while($n>1) {
      last if defined $happy[$n] && $happy[$n]==1;
      if(defined $happy[$n] || $seen{$n}) { ## Unhappy no...
        ($_<1540) && ($happy[$_] = 0) for keys %seen;
        redo OUT;
      }
      $seen{$t=$n}=1,$n=0;
      do {$n+=($t%10)**2} while $t=int($t/10);
    }
    ($_<1540) && ($happy[$_]=1) for $N, keys %seen;
    push @ret,$N;
  }
  @ret;
}
```

**Note** This value is roughly linear in `n` - asymptotic value is around `24.4 x n`.

### Pre-computing cache

```
sub happy_list_precache {
  state @happy;
  my( $L, $count, $t, @ret, %seen ) = ( 1_640, @_ ? $_[0] : 8 );

  unless( @happy ) {
    @happy=(0,1);
    O: for my $N ( 2..$L ) {
      my $n = $N;%seen=();
      while($n>1){
        last if defined $happy[$n] && $happy[$n]==1;
        if( defined $happy[$n] || $seen{$n} ) {
          $happy[$_]=0 for keys %seen;
          next O;
        }
        $seen{$t=$n}=1,$n=0;
        do {$n+=($t%10)**2} while $t=int($t/10);
      }
      $happy[$_]=1 for $N, keys %seen;
    }
  }

  ## Now loop through until we have a list of first $count happy
  ## numbers.
  ## If we wanted to use this method in an if_happy function - could
  ## equally replace this with
  ## return $happy[$N] if $N <= $L;
  ## my $n=0;
  ## do {$n+=($N%10)**2} while $N=int($N/10);
  ## return $happy[$n];
  my $N=0;
  for (1..$count) {
    $N++;
    if( $N <= $L ) {
      $happy[$N] || redo;
    } else {
      my $n=0,$t=$N;
      do {$n+=($t%10)**2} while $t=int($t/10);
      $happy[$n] || redo;
    }
    push @ret,$N;
  }
  @ret;
}
```

We can use this technique to create an optimized version of `is_happy` - as we are using a `state` variable to store the cache

```perl
sub is_happy_precache {
  state @happy;
  my( $L, $N, $t, @ret, %seen ) = ( 1_640, $_[0] );

  ## Set up cache if empty
  unless( @happy ) {
    @happy=(0,1);
    O: for my $N ( 2..$L ) {
      my $n = $N;%seen=();
      while($n>1){
        last if defined $happy[$n] && $happy[$n]==1;
        if( defined $happy[$n] || $seen{$n} ) {
          $happy[$_]=0 for keys %seen;
          next O;
        }
        $seen{$t=$n}=1,$n=0;
        do {$n+=($t%10)**2} while $t=int($t/10);
      }
      $happy[$_]=1 for $N, keys %seen;
    }
  }

  ## Get value from cache....
  if( $N > $L ) {    ## If not in cached array we replace
    my $n=$N,$N=0;   ## $N by the sum of it's digits squared
    do {$N+=($n%10)**2} while $n = int($n/10);
  }
  $happy[$N];        ## And look up value in the cache..
}
```

### Relative performance:

Computing list of first 1,000,000 happy values

|                   | time  | is_happy | list_cache | list_cache_limit | is_precache | list_precache |
| :---------------- | ----: | -------: | ---------: | ---------------: | ----------: | ------------: |
| is_happy          |  69.1 |       -- |       -75% |             -78% |        -84% |          -87% |
| list_cache        |  17.0 |     306% |         -- |             -11% |        -37% |          -47% |
| list_cache_limit  |  15.1 |     356% |        12% |               -- |        -29% |          -40% |
| is_precache       |  10.8 |     542% |        58% |              41% |          -- |          -16% |
| list_precache     |  9.04 |     664% |        88% |              67% |         19% |            -- |

 * So we can see both `precache` methods are most efficient being over **40%** faster that every other method.
 * The best method `list_precache` is nearly **8** times faster than the naive looping and calling our `is_happy` function repeatedly.
 * Limiting the cache to just those numbers below 1540 has a slight performance gain about `1/8` over the one where we store every value in the cache. For values over `1540` we only ever store data in the cache and not retrieve it.
