[< Previous 192](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-192/james-smith) |
[Next 194 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-194/james-smith)

# The Weekly Challenge 193

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-193/james-smith

# Task 1 - Binary string

***You are given an integer, `$n > 0`. Write a script to find all possible binary numbers of size `$n`.***

## Solution

This weeks task 1 is relatively simple. (1) We need to work out what the minimum and maximum
integers are and then just print them padded to the right length. Thankfully Perl is great
at this as it is integral to it's design.

The largest value is '(2^n)-1' and the template for `sprintf` is '`%0{n}b`'. Which gives us

```perl
sub all_binary {                             ## Make a template so we don't have
  my $t = "%0$_[0]b";                        ## to do interpolation everytime
  map { sprintf $t, $_ } 0 .. (1<<$_[0])-1   ## Need brackets as - is actioned                                         
}                                            ## before <<.
```
# Task 2 - Odd String

***You are given a list of strings of same length, `@s`. Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. `a = 0`, `b = 1`, ... `z = 25`.***

You are given a list of integers greater than or equal to zero, `@list`. Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print `-1`

## Solution

```perl
sub odd_string_array {
  my %x;
  ## Keyed by signature - so one key will have
  push @{$x{
      ord( substr $_, 1 ) *  99
    + ord( substr $_, 2 )
    - ord( $_           ) * 100
  }}, $_ for @_;
  [ grep { @{$_}==1 } values %x ]->[0][0]
}
```

### Faster solution..

```perl
sub odd_string_fast {
  my($x1,$x2,$y1,$y2,$z1,$z2) = (
    ord($_[0]) - ord(substr$_[0],1), ord($_[0]) - ord(substr$_[0],2),
    ord($_[1]) - ord(substr$_[1],1), ord($_[1]) - ord(substr$_[1],2),
    ord($_[2]) - ord(substr$_[2],1), ord($_[2]) - ord(substr$_[2],2),
  );
  if( $x1 == $y1 && $x2 == $y2 ) { ## First & second match so NOT 1st
    if( $x1 == $z1 && $x2 == $z2 ) { ## Third matches first - so find first which doesn't
      ( $x1 != ord($_) - ord(substr$_,1) || $x2 != ord($_) - ord(substr$_,2) ) && return $_ for @_[3..$#_];
    } else {
      return $_[2];
    }
  } ## Different so it must be 1st or ceons
  $_[ $x1 == $z1 && $x2 == $z2 ? 1 : 0 ]
}
```
