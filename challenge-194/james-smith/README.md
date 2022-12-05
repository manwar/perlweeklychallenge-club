[< Previous 193](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-193/james-smith) |
[Next 195 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-195/james-smith)

# The Weekly Challenge 194 - *iffy* solutions

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-193/james-smith

# Task 1 - Digital Clock

***You are given time in the format `hh:mm` with one missing digit. Write a script to find the highest digit between `0`-`9` that makes it valid time.***

## Solution

```perl
sub digit_2359 {
  sub {
    $_[0] eq '?' ? ( $_[1]<4 ? 2 : 1 )
  : $_[1] eq '?' ? ( $_[0]<2 ? 9 : 3 )
  : $_[3] eq '?' ? 5 : 9
  }->( split //, $_[0] );
}
```

My original code allowed `24:00` as a valid value - this gave a slightly more complicated sub...

```perl
sub digit_2400 {
  sub {
    $_[0] eq '?' ? ( $_[1]==4 && $_[3]==0 && $_[4]==0 || $_[1]<4 ? 2 : 1 )
  : $_[1] eq '?' ? ( $_[0]<2 ? 9 : $_[3]==0 && $_[4]==0 ? 4 : 3 )
  : $_[3] eq '?' ? 5 : 9
  }->( split //, $_[0] );
}
```

# Task 2 - Frequency Equalizer

***You are given a string made of alphabetic characters only, `a`-`z`. Write a script to determine whether removing only one character can make the frequency of the remaining characters the same.***

## Solution

```perl
sub check {
  my %sc; $sc{$_} ++ for split //,$_[0];
  sub { @_>2 && $_[0]==$_[1]+1 && $_[-1]==$_[1] ? 1 : 0 }->(sort {$b<=>$a} values %sc);
}
```
