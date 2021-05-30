# Perl Weekly Challenge #114

# What no regexs or loops....

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-114/james-smith/perl

# Challenge 1 - Next highest palindrome

***You are given a positive integer `$N`. Write a script to find out
the next Palindrome Number higher than the given integer `$N`.***

## The solution - naive

We will see this again for the next challenge we just increment `$N`
until we find another palindrome.

```perl
sub next_palindrome_naive {
  my ($n) = @_;
  1 until ++$n eq reverse $n;
  return $n
}
```

## The solution - optimized

First we note that it is easier to compute the palindrome greater than
equal to itself {so we just incremement the passed parameter}.

We should then be able to do away with the loop entirely as the
palindromic number will either have the same first half as itself OR
will have this value incrememented by 1 as the first half.... No loop
requried..

### The cases..

There are two cases we need to consider:

 * There are an even number of digits
 * There are an odd number of digits..

The first case is slightly easiers as we just check to see if the
palindrome created by reversing the first digits and putting them
at the end is greater than or equal to the number, and if not
increment and try again.

The second case is slightly more interesting as we have the middle
digit to consider. In the 2nd half above we can increment the middle
digit if (less than 9) OR incremennt the first digits..

```perl
sub next_palindrome {
  my $p  = 1 + shift;
  my $x = substr $p, 0, (length $p)>>1;
  if( 1 & length $p ) {
    my $y = substr $p, (length$p)>>1, 1;
    return $x.$y.reverse $x      if $p <= $x.$y.reverse $x;
    return $x.($y+1).reverse $x  if $y<9;
    $x++;
    return $x.'0'.reverse $x;
  } else {
    $x++ if $p > $x.reverse $x;
    return $x.reverse $x;
  }
}
```

## Notes and Summary

You will note I've used the "Yoda" form of some of the expressions
inequalities. It is much easier for instance to realise that:
`1 & length $p` is "and"ing `1` with the length of `$p` rather than
"and"ing `1` with `$p` and then taking the length (which will be 1) if
you were to write `length $p & 1`...

There were some cases where I thought assigning the result of
`reverse$x` and `length$p` would speed things up - but it seemed to
slow things down by 10% or so - So I'm assuming there is some neat
code in the interpreter/compiler does this cacheing for you.

For small numbers of `$N` there is little difference in the performance
15% - but as soon as numbers are up to 3/4 digits then the optimised
version is 6 times faster, for 5/6 digits 80 times faster, for 7/8
approximately 1000 times faster...

# Challenge 2 - Higher Integer Set Bits

***You are given a positive integer `$N`. Write a script to find
the next higher integer having the same number of 1 bits in binary
representation as `$N`.***


## The solution - naive

There is a simple solution we can try - and that is to take the number,
count the number of 1-bits, and then just increment repeatedly until we
get a number with the same amount of 1-bits.

```perl
sub next_bin {
  my $n = shift;
  my $c = (sprintf '%b', $n) =~ tr/1/1/;
  while(++$n) {
    return $n if $c == ( (sprintf '%b', $n) =~ tr/1/1/ );
  }
}
```

 * We convert the number to binary using sprintf with the format `'%b'`;
 * We count the number of "1"s in the string using `tr`. `tr/1/1/` leaves the string unchanged but returns the number of "1"s that were replaced.

## The solution - optimized

We can easily find a solution to this problem.

If the number contains a pair of digits "01" then we can find a number
that is larger but has the same number of digits by swapping the "01" to "10".
(Note we can force the binary representation to always have a "01" by prefixing
the binary representation with "0")

So e.g. `174 = 1010 1110` - you can replace either of the `01`s to give either:

 * `1100 1110 = 206`
 * `1011 0110 = 182`

We note that to minimize the number we start by replacing the last `01` by `10`

So we have: `182 = 1011 0110 > 174 = 1010 1100`

The digits after the last `01` will be of the form `1...10..0`, so we can again
reduce the value by flipping this string around to be `0...01...1`;

So now we have: `179 = 1011 0011 > 174 = 1010 110`

The code then becomes either:

```perl
sub next_bin_rex {
  return oct '0b'.sprintf('0%b',shift) =~ s{01(1*)(0*)$}{10$2$1}r;
}
```
or

```perl
sub next_bin_rrev {
  my $t = rindex my $s = sprintf('0%b',shift),'01';
  return oct '0b'.substr($s,0,$t).'10'.reverse substr $s,$t+2;
}
```

depending on whether or not you use a regular expression to find
the last "`01`" in the binary representaiton.

## The solution - with go faster stripes...

After a discussion on facebook with Eliza Skr, about whether or not
to use regexs rather than `rindex` she supplied a different algorithm
for finding the next number - which didn't involve manipulating the
binary string but by working out the arithmetic to make the changes.

 * The number is of the form is `0 1111 00000000`
 * The next hightest number is  `1 000000000 111`
 * To map `0 1111 00000000` to `1 000000000 000` we need to add
   `1 00000000` (which is 2^#zeros)
 * To map `1 000000000 000` to `1 000000000 111` we need to add `111`
   which is 2^(#ones -1) -1

Eliza's solution was to obtain counts of `0`s and `1`s using a simple
regex `/(1+)(0*)$/` which works - but is still a regex... so we can
replace this again with using `rindex`... Also rather than using 
`2**$n` this can be replaced by the much quicker `1<<$n` which does
the same thing but is much more efficient.

This gives us:

```perl
sub next_bin_rindex2 {
  my $t=rindex my$s=sprintf('%b',$_[0]),'1';
  return $_[0] + (1<<(-1-$t+length$s))
           - 1 + (1<<(-1+$t-rindex$s,'0',$t));
}
```

A few notes:

 * here we use the three parameter version of `rindex`,
   which allows you to specify an offset for the search to start (in this
   case we want the last "`0`" before the last "`1`" so we use the position
   of the "`1`" as the offset)
 * I repeat we use the bit-shift operator `<<` to raise to the power `2`
   rather than the power operator.... This is very much more efficient
   - infact all the efficiency gain between the 2 `rindex` solutions is
   due to using this over '`**`'...
 * I looked to see if unpack was more efficient than sprintf - but found
   that this was not the case {about 20-40% slower}.

## Summary

Both the performance of `next_bin_regex` and `next_bin_rrev` appear
to slow down only slightly as `$N` increases - comparabale with 
"linear" scans for the last "`01`". Interestingly the rind2 seems to
run at similar speeds for all ranges of `$N`.

The naive `next_bin` - doesn't have that property - at all and it
rapidly tails off performance wise.

Running this a large number of times - we have the following
approximate rates for the calculations....

| Size of number | Rate rind2 | Rate rrev  | Rate regex | Rate naive |
| -------------- | ---------: | ---------: | ---------: | ---------: |
| 1-500          |  1,900,000 |  1,550,000 |    500,000 |    600,000 |
| Approx 1000    |  1,800,000 |  1,500,000 |    440,000 |    400,000 |
| Approx 1x10^6  |  1,800,000 |  1,350,000 |    390,000 |      4,000 |
| Approx 1x10^9  |  1,850,000 |  1,250,000 |    330,000 |          1 |

The calls do include the hardest example `2^n-1` for which the next
number is `2^(n-1)` more - so much of the time in the naive loop is
taken up by that example - in the 1x10^9 example this would require
500_000_000 iterations of the increment/check loop.

We see as we did a few weeks ago that if you don't actually need to
use regexs then you can get an appreciable speed boost. Obviously
remembering there is trade off between coding and running time.
