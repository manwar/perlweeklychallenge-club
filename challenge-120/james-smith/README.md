# Perl Weekly Challenge #120

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-119/james-smith/perl

# Task 1 - Swap bits

***You are given a positive integer `$N` less than or equal to `255`. Write a script to swap the odd positioned bit with even positioned bit and print the decimal equivalent of the new binary representation.***

## The solution

This is very similar to last weeks challenge - but instead of swapping bits 4-7 with bits 0-3 this time we are swapping even bits with odd bits - so the solution is similar...

The even bits are found by bit-wise *and*ing the number with `0b01010101` 0r `0x55` (`85` decimal) and the odd bits are found by bit-wise anding with `0b10101010` or `0xaa` (`170` decimal). We then switch them by multiplying or dividing by 2 {which we do with the bit shift operators `<<` & `>>`}. We just have to add the two values together - as we know the bits don't overlap we can use `|` rather than `+`.

```perl
sub switch_bits {
  ($_[0]&0xaa)>>1 | ($_[0]&0x55)<<1;
}
```

# Task 2 - Clock Angle

***You are given time `$T` in the format `hh:mm`. Write a script to find the smaller angle formed by the hands of an analog clock at a given time.***

## The solution

Given a time we can compute the position of the hour hand as `$hr*30+$min/2` and the minute hand as `$min*6`.

We can then get the angle between the two as: `($hr*60+$min-$min*12)/2`

We want to reduce this modulo `360` to map the value to the range `0` - `360`. **BUT** we note that `$min` may be odd and the value of the angle may therefore may not be a whole number. To get round this we perform the modulus (by `720`) before the divide by `2`.

This gives us a number between `0` and `360`. But we need a number between `0` and `180`. To map the range `180` - `360` we can either use an IF OR we can note that if we
do `abs(angle - 180)` we get the complementary angle. So we just subtract this from `180` giving the method below...

```perl
sub clock_angle_1_liner {
  180-abs((60*(substr$_[0],0,2)-11*substr$_[0],3)%720/2-180);
}
```

Compared to this (perhaps slightly more readable) method there is about a 60% performance gain [avoiding variables!]
```perl
sub clock_angle {
  my($h,$m) = split /:/,shift;
  my $t = abs($h*60-$m*11)%720/2;
  return $t > 180 ? 360-$t : $t;
}
```

**Note** We can gain more speed (90% faster than "simple" method and about 15% faster than the 1-liner) by removing the first `substr` but to do so we need to disable `numeric` warnings - `no warnings qw(numeric)`.

```perl
sub clock_angle_fast {
  180-abs((60*$_[0]-11*substr$_[0],3)%720/2-180);
}
```

(Without disabling warnings this gives `Argument "04:00" isn't numeric in multiplication (*) at ..` errors)
