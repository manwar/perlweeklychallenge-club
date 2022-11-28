[< Previous 191](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-191/james-smith) |
[Next 193 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-193/james-smith)

# The Weekly Challenge 192

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-190/james-smith

# Task 1 - Binary Flip

***You are given a positive integer, `$n`. Write a script to find the binary flip.***

## Solution

### Use maths...

This isn't as simple as using `~` as this will flip ALL the bits including those before the first 1.

We need to therefore work through bit by bit reducing the number until we have reach zero.

We use the right shift operator to reduce `$n` each time. We have to push the values back onto the
answer. We can do this with addition - actually as we using bit-operators elsewhere we use the `|` operator

If the last digit is `1` we do nothing, if the last digit is `0` where add `2^$k` where $k is the
position we are currently checking. Note as we are right-shifting we have to increase `$k` each time.

```perl
sub binary_flip {
   my($r,$k,$n) = (0,0,shift);
   $r|=(~$n&1)<<$k++,$n>>=1 while $n;
   $r;
}
```

### Use strings...

This can also be done by converting to a string and then coverting back again.

```
sub string_flip {
  $_[0] ? oct '0b'.sprintf('%b',$_[0])=~tr/01/10/r : 0;
}
```

We use `tr` with the `r` option to return the result of the translation...

Note we have to check whether the input is `0` as in this case the output is also `0` as there is no leading 1.

### Performance...

Well this is where Perl is uber fast when it comes to strings - the string solution is faster than the bit manipulation. This is probably due to the overhead of each separate operation in the numeric version. For a test example of "12345678" (`1011 1100 0110 0001 0100 1110`) the string method is 8x faster than the binary method.

### Let's try again...

Annoyed with the fact the elegant {bit operator based} solution is slower than the "hacky" string one - let's revisit the code using inline C - effectively it is EXACTLY the same algortihm as our first perl method.

```C
int c_flip(int n) {
  int r=0;
  int k=0;
  while(n) {
    r|=(1^n&1)<<k++;
    n>>=1;
  }
  return r;
}
```

Now - when comparing this to the other two: The C version is 4.5 times faster than the string version OR 35x faster than the equivalent Perl version.

A further re-write of the C gives:

```C
int c2(int n) {
  int o = n;
  int m = 0;
  while(o) {
    m<<=1;
    m++;
    o>>=1
  }
  return n^m;
}
```

Here we compute a mask of `1`s as long as the binary representation of the number so for `25` = `11001` we have a mask of `11111` and so doing a bitwize XOR operation gives us `00110` or `6`. Which is even faster as it only does the XOR (`^`) once. {approx 5 times faster than the regex version}

# Task 2 - Equal Distribution

***You are given a list of integers greater than or equal to zero, `@list`. Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print `-1`***

## Solution

```perl
sub equal_dis {
  my($av,$k) = (0,0);
  $av+=$_ for @_;
  return -1 if $av%@_;
  $av/=@_;
  $k+=abs($av-$_[0]),$_[1]-=$av-shift while @_>1;
  $k;
}
```

The first thing to realise is that we only have a solution if the digits up to a multiple of the length of the list.

So first thing we do is work out the sum and see if it is divisible by the length.

Second is how to work out the number of steps. This is easier than you think. We only have to consider the case where we move numbers right to left or left to right, starting at the left. We are not bothered whether any number becomes negative.

So (1) how much do we need to move? This is simply `$av - $A[$p]`. So we borrow it from the next number so `$A[$p+1] = $A[$p+1] - $av + $A[$p]` and the number of steps is just `abs($av-$A[$p])`. Giving the code above.

### A minor optimization

We can do away with the array - and just use a scalar for the "size" of the next bin - giving us:

```perl
sub equal_dis2 {
  my($av,$k,$f) = (0,0,$_[0]);
  $av+=$_ for @_;
  return -1 if $av%@_;
  $av/=@_;
  $k+=abs($av-$f),$f=$_[$_]-$av+$f for 1..$#_;
  $k;
}
```

