# Odd Conflicts

**Challenge 367 solutions in Perl by Matthias Muth**

## Task 1: Max Odd Binary

> You are given a binary string that has at least one ‘1’.<br/>
> Write a script to rearrange the bits in such a way that the resulting binary number is the maximum odd binary number and return the resulting binary string. The resulting string can have leading zeros.
>
> **Example 1**
>
> ```text
> Input: $str = "1011"
> Output: "1101"
> 
> "1101" is max odd binary (13).
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "100"
> Output: "001"
> 
> "001" is max odd binary (1).
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "111000"
> Output: "110001"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "0101"
> Output: "1001"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "1111"
> Output: "1111"
> ```

There are two things that make the a binary number
with a given number of `1` bits the 'largest odd integer':

* To be odd, the least significant bit has to be `1`.
* To be the largest, all other `1` bits have to represent as high a value as possible, meaning they have to be the most significant bits.  

So what we need is the number of `1` bits in the input binary string, and its total number of bits. The number of bits is the same as the length of the bit string. The number of `1` bits can be counted using the `tr` operator, like `$str =~ tr/1//`.

Then we can return the resulting bit string, constructed using the `x` operator for its three parts:

```perl
use v5.36;

sub max_odd_binary( $str ) {
    my ( $n_bits, $n_ones ) = ( length( $str ), $str =~ tr/1// );
    return "1" x ( $n_ones - 1 )
        . "0" x ( $n_bits - $n_ones )
        . "1";
}
```

Nice and easy challenge!

## Task 2: Conflict Events

> You are given two events start and end time.<br/>
> Write a script to find out if there is a conflict between the two events. A conflict happens when two events have some non-empty intersection.
>
> **Example 1**
>
> ```text
> Input: @event1 = ("10:00", "12:00")
>        @event2 = ("11:00", "13:00")
> Output: true
>
> Both events overlap from "11:00" to "12:00".
> ```
>
> **Example 2**
>
> ```text
> Input: @event1 = ("09:00", "10:30")
>        @event2 = ("10:30", "12:00")
> Output: false
>
> Event1 ends exactly at 10:30 when Event2 starts.
> Since the problem defines intersection as non-empty, exact boundaries touching is not a conflict.
> ```
>
> **Example 3**
>
> ```text
> Input: @event1 = ("14:00", "15:30")
>        @event2 = ("14:30", "16:00")
> Output: true
>
> Both events overlap from 14:30 to 15:30.
> ```
>
> **Example 4**
>
> ```text
> Input: @event1 = ("08:00", "09:00")
>        @event2 = ("09:01", "10:00")
> Output: false
>
> There is a 1-minute gap from "09:00" to "09:01".
> ```
>
> **Example 5**
>
> ```text
> Input: @event1 = ("23:30", "00:30")
>        @event2 = ("00:00", "01:00")
> Output: true
>
> They overlap from "00:00" to "00:30".
> ```

It's not too difficult to translate times given in `HH:MM` form into minutes since midnight. As this has to be done four times, I use a `map` call, in combination with a `/^(\d+):(\d+)/` regular expression:

```perl
    my @times =
        map { /^(\d+):(\d+)/; $1 * 60 + $2 } $event1->@*, $event2->@*;
```

This translates the four event times into `$times[0]` to `$times[3]`.

I want to be sure that the ending time of an event is greater than (or equal to) its starting time. For an event like `( "23:00", "00:30" )` that spans midnight, I therefore add one day (24 * 60 minutes) to its ending time.<br/>
Doing this for both events separately:

```perl
    $times[1] += 24 * 60
        if $times[1] < $times[0];
    $times[3] += 24 * 60
        if $times[3] < $times[2];
```

Now for the difficult part: the overlap detection.<br/>
I started with the criteria for two events A and B to *not* overlap. This is the case when either of these is true:

+ event A starts *after* event B ends,
+ or event A ends *before* event B starts.

A logical inversion results in these criteria for two *conflicting* events:

* event A starts before event B ends,
* *and* event A ends after event B starts. 

Translated into code it looks like this:

```perl
    $times[0] < $times[3] && $times [1] > $times[2]
```

Very well, but this does not consider events that might conflict *after midnight*.

These are the events from Example 5, together with the minutes since midnight of their respective starting and ending times:

* Event 1: `("23:30", "00:30")`, minutes `1410` to `1470`<br/>
  (that is 23 * 60 + 30, and 0 * 60 + 30 + 24 * 60, remember we add one day to span midnight),
* Event 2: `("00:00", "01:00")`, minutes `0` to `60`.

Strictly speaking, they do not overlap. But apparently, they should be considered overlapping.<br/>To achieve this, I added two more checks:

* check whether Event 1 collides with Event 2 *tomorrow*,
* and as the events might be in opposite order:<br/>
  check whether Event 1 *tomorrow* collides with Event 2 as it is.

An interesting challenge, but definitely no one-line solution for me this time!

```perl
use v5.36;

sub conflict_events( $event1, $event2 ) {
    my @times =
        map { /^(\d+):(\d+)/; $1 * 60 + $2 } $event1->@*, $event2->@*;
    $times[1] += 24 * 60
        if $times[1] < $times[0];
    $times[3] += 24 * 60
        if $times[3] < $times[2];
    return $times[0] < $times[3] && $times [1] > $times[2]
        || $times[0] + 24 * 60 < $times[3] && $times [1] + 24 * 60 > $times[2]
        || $times[0] < $times[3] + 24 * 60 && $times [1] > $times[2] + 24 * 60;
}
```

#### **Thank you for the challenge!**
