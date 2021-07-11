# Perl Weekly Challenge #120

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-120/james-smith/perl

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

To make sure the angle is between `-360` and `360` we have to ensure that the hour is between `0` and `11`, by reducing it module 12. We then get the absolute value so we have a value between `0` and `360`

We need a number between `0` and `180`. To map the range `180` - `360` we can either use an IF OR we can note that if we
do `abs(angle - 180)` we get the complementary angle. So we just subtract this from `180` giving the method below...

```perl
sub clock_angle_1_liner {
  180-abs(abs((substr$_[0],0,2)%12*30-5.5*substr$_[0],3)-180);
}
```

Compared to this (perhaps slightly more readable) method there is about a 85% performance gain [avoiding variables!]
```perl
sub clock_angle {
  my($h,$m) = split /:/,shift;
  my $t = abs($h%12*30-$m*5.5);
  return $t > 180 ? 360-$t : $t;
}
```

**Note** We can gain more speed (110% faster than "simple" method and about 15% faster than the 1-liner) by removing the first `substr` but to do so we need to disable `numeric` warnings - `no warnings qw(numeric)`.

```perl
sub clock_angle_fast {
  180-abs(abs($_[0]%12*30-5.5*substr$_[0],3)-180);
}
```

(Without disabling warnings this gives `Argument "04:00" isn't numeric in modulus (%) at ..` errors)

# Solutions in CESIL

OK - last weeks CESIL challenge was easier than this weeks....

Due to not having bit wise operations or an easy convert between hex and binary we have to find an alternative solution.

## Task 1

 * In this case we work through the pairs of bits flipping them round.
 * We compute the value of the bits by dividing though by 64 (then 16, 4, (and 1)) and taking the integer value.
 * If the value is 0 or 3 then we do nothing otherwise we map 1 to 2 and 2 to 1 respectively....
 * we repeat 4 times for each pair and keep a running sum which gives us our answer...

```
        LINE
        LOAD  +0
        STORE success
        STORE tests
Next    IN
        JINEG End
        STORE a
        OUT
        IN
        STORE ans
        LOAD +0
        STORE res
        LOAD +64
Loop    STORE divisor
        LOAD a
        DIVIDE divisor
        SUBTRACT 1
        JIZERO j_1
        SUBTRACT 1
        JIZERO j_2
        ADD 2
        JUMP j
j_1     LOAD   +2
        JUMP j
j_2     LOAD   +1
j       MULTIPLY divisor
        ADD res
        STORE res
        LOAD a
        DIVIDE divisor
        MULTIPLY divisor
        MULTIPLY -1
        ADD a
        STORE a
        LOAD divisor
        DIVIDE +4
        JIZERO EndL
        JUMP Loop
EndL    LOAD res
        PRINT " => "
        OUT
(Now run the test!
        PRINT " : "
        SUBTRACT ans
        JIZERO Ok
        PRINT "-- should be "
        LOAD ans
        OUT
        PRINT "?"
        JUMP Line
Ok      PRINT "OK"
        LOAD success
        ADD +1
        STORE success
Line    LINE
        LOAD tests
        ADD +1
        STORE tests
        JUMP Next
End     LINE
        PRINT "TESTS: "
        LOAD success
        OUT
        PRINT " of "
        LOAD tests
        OUT
        PRINT " passed"
        LINE
        LINE
        HALT
        %
        101
        154
        18
        33
        154
        101
        33
        18
        -1
```
Output...
```
101 => 154 : OK
18 => 33 : OK
154 => 101 : OK
33 => 18 : OK

TESTS: 4 of 4 passed
```

## Task 2

**CAVEAT:**
 * Can't cope with "odd minutes" as this will lead to a fractional angle {and CESIL is integer only}
 * Can't handle non-integer input - so the times have to be put in without the : so `03:30` is put in as `0330`
```
( Compute the angle between the hour and minute hand
( Input contains of pairs of hour.minute & answer so
( can check calculations are OK!
        LINE
        LOAD  +0
        STORE success
        STORE tests
Next    IN
        JINEG End
        STORE mn
        DIVIDE 100
        STORE hr
        MULTIPLY -100
        ADD mn
        STORE mn
        LOAD hr
        SUBTRACT +10
        JINEG bl1
        JUMP bl1e
bl1     PRINT "0"
bl1e    ADD +10
        OUT
        PRINT ":"
        LOAD mn
        SUBTRACT +10
        JINEG bl2
        JUMP bl2e
bl2     PRINT "0"
bl2e    ADD +10
        OUT
        IN
        STORE ans
        LOAD mn
        PRINT " => "
        MULTIPLY -11
        DIVIDE +2
        STORE t
        LOAD hr
        SUBTRACT 12
        JINEG lt12
        JUMP gt12
lt12    ADD +12
gt12    MULTIPLY +30
        ADD t
        JINEG lt0
        JUMP gt0
lt0     MULTIPLY -1
gt0     SUBTRACT +180
        JINEG ltx0
        MULTIPLY -1
ltx0    ADD +80
        JINEG lt100
        JUMP gt100
lt100   PRINT " "
        ADD +90
        JINEG lt10
        JUMP gt10
lt10    PRINT " "
gt10    SUBTRACT +90
gt100   ADD +100
        OUT
        PRINT " : "
        SUBTRACT ans
        JIZERO Ok
        PRINT "-- should be "
        LOAD ans
        OUT
        PRINT "?"
        JUMP Line
Ok      PRINT "OK"
        LOAD success
        ADD +1
        STORE success
Line    LINE
        LOAD tests
        ADD +1
        STORE tests
        JUMP Next
End     LINE
        PRINT "TESTS: "
        LOAD success
        OUT
        PRINT " of "
        LOAD tests
        OUT
        PRINT " passed"
        LINE
        LINE
        HALT
        %
        0318
        9
        0420
        10
        0440
        100
        0310
        35
        0400
        120
        0800
        120
        1600
        120
        1800
        180
        2000
        120
        -1
```
Output:
```
03:18 =>   9 : OK
04:20 =>  10 : OK
04:40 => 100 : OK
03:10 =>  35 : OK
04:00 => 120 : OK
08:00 => 120 : OK
16:00 => 120 : OK
18:00 => 180 : OK
20:00 => 120 : OK

TESTS: 9 of 9 passed
```
