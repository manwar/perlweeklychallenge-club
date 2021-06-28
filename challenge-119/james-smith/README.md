# Perl Weekly Challenge #119

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-119/james-smith/perl

# Task 1 - Swap Nibbles

***You are given a positive integer `$N`. Write a script to swap the two nibbles of the binary representation of the given number and print the decimal number of the new binary representation.(((

## The solution

This is a simple binary manipulation problem.

We can isolate the lower-nibble by bit-wise `&`ing with `15` or `00001111`. We then move it to the upper-nibble by multiplying by `16` OR using the bit-shift operator `<<` to move the bits 4 spaces to the left.

We can isolate the upper-nibble by bit-wise `&`ing with `240` or `11110000`, and again use the bit-shift operator `>>` to move 4 bits to the right. BUT actually we don't need to perform the bit-wise `&` IF we assume the number is in range (`0`..`255`). As the `>>` operator just drops the bits shifted off.

To stitch it back together we just `|` the two numbers together.

```perl
sub swap_nibble {
  return ($_[0]>>4) | (($_[0]&15)<<4);
}
```


# Task 2 - Sequence without 1-on-1

***Write a script to generate sequence starting at 1. Consider the increasing
sequence of integers which contain only 1’s, 2’s and 3’s, and do not have any
doublets of 1’s like below. Please accept a positive integer `$N` and print
the `$N`th term in the generated sequence.***

```
1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...
```

## The solution

Note this is a first pass solution....

To avoid splitting/unsplitting - we will keep the digits as an array.
We then just increment the last entry of the array, and carry over
any bits to the previous entry. Finally if we get to the start of the
array we unshift a 1 in front of it...

In the outer loop we compute the next number - but we don't increment
the counter if the number has two adjacent 1s. [ We actually increment
and decrement it - which has the same effect. ]

```perl
sub no_11 {
  my( $n, $ptr, @v ) = ( shift, undef, 0 );
  for( my $i = 0; $i < $n; $i++ ) {
    for( $ptr = $#v; $ptr>-1 && ++$v[$ptr]>3; $ptr--) {
      $v[$ptr]=1;
    }
    unshift @v,1 if $ptr < 0;
    $i-- if "@v"=~m{1 1};
  }
  return join q(),@v;
}
```

Comparing this to the pure script using numbers and filtering out those
that contain any of the digits `0`, `4` through `9` or the string `11`
using a regexp sees an approximately `15x` speed up. If you optimize
the filter using a series of index calls you can double the speed of the
code at the expense of a slightly longer function BUT it is still less
than a seventh of the performance of the array version.

```perl
sub no_11_filter {
  my $n = shift;
  my $v = 0;
  while(1){
    return $v unless $n;
    $v++;
    $n-- if 0 > index( $v,'4' ) && 0 > index( $v,'0'  )
         && 0 > index( $v,'5' ) && 0 > index( $v,'6'  )
         && 0 > index( $v,'7' ) && 0 > index( $v,'8'  )
         && 0 > index( $v,'9' ) && 0 > index( $v,'11' );
  }
}

```

### Making the code more readable....

This is a nice challenge to make the code more "readable", by encapsulating our new "number" string as an object.

We will overload it's increment operator so that we can generate the sequence

```
   1, 2, 3, 11, 12, 13, 21, 22, 23, 31, 32, 33, 111
```

The object itself is just a blessed array.

We use `overload` to define both the "increment" operator `++` and the "stringfy"
operator "".

We then define a simple method to test whether or not the "string" contains a double 1.

The package code is below - but first the loop in the code:

```perl
sub no_11_object {
  my( $n, $v ) = ( shift, Three->new );
  for( my $i = 0; $i < $n; $v++, $i++ ) {
    $v++ while $v->has_double_one;
  }
  return "$v";
}
```

```perl
package Three;

use overload '++' => 'incr';
use overload '""' => 'str';

sub new {
  my $x = [0];
  bless $x, 'Three';
  return $x;
}

sub has_double_one {
  my($f,@v) = @{$_[0]};
  while(@v) {
    return 1 if ($f == 1) && $v[0] == 1;
    $f = shift @v;
  }
  return 0;
}

sub incr {
  my $v = shift;
  my $ptr;
  for( $ptr = @{$v}-1; $ptr>-1 && ++$v->[$ptr]>3; $ptr--) {
    $v->[$ptr] = 1;
  }
  unshift @{$v}, 1 if $ptr < 0;
}

sub str {
  return join '', @{$_[0]};
}

1;
```
