[< Previous 197](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-197/james-smith) |
[Next 199 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-199/james-smith)

# The Weekly Challenge 198

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-198/james-smith

# Task 1 - Max Gap

***You are given a list of integers, `@list`. Write a script to find the total pairs in the sorted list where 2 consecutive elements has the max gap. If the list contains less then 2 elements then return 0.***

## Solution
```perl
sub max_gap_sort {
  return 0 unless $#_;
  @_ = sort { $a <=> $b } @_;
  my $p = shift;
  @_ = sort { $b <=> $a } map { ($_-$p,$p=$_)[0] } @_;
  $_[0]==$_[$_] || return $_ for 1..$#_;
  1*@_
}
```

```perl
sub max_gap_nosort {
  return 0 unless $#_;
  @_ = sort { $a <=> $b } @_;
  my($p,$b,$c)=(shift,0,0);
  $_-$p>$b ? ($b,$c)=($_-$p,1) : $_-$p==$b && $c++, $p=$_ for @_;
  $c;
}
```

# Task 2 - Prime Count

***You are given an integer `$n > 0`. Write a script to print the count of primes less than `$n`.***

## Solution

```perl
sub n_primes_compact {
  return 0if(my$n=shift)<3;
  @_=2;
  //,(grep{($'%$_)||next}@_),push@_,$_ for 3..$n-1;
  1*@_
}
```

```perl
sub n_primes_fast { # for all tests 0.066 seconds
  return 0 if (my $n=shift) <3;
  my @p = (my $q=2);
  O: for( my $i=3; $i<$n; $i+=2 ) {
    $q++ if $i>$q*$q;
    for(@p) {
      next O unless $i%$_;
      last if $_>$q;
    }
    push @p, $i;
  }
  scalar @p
}
```
