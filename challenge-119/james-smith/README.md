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

## Other languages

I've included some other language versions of this code...

The first 3 are just direct lifts as Javascript, PHP and Python all have bit shift and bitwise operators! The fourth tho' is a bit of curveball "CESIL" the first
language I was "taught" at school - the code was run from punch cards and the printout was on green bar paper!

### Javascript
```javascript
TESTS = [ [101,86],[18,33] ];

TESTS.forEach(_ => console.log( swap_nibble( _[0] ) == _[1] ? 'OK' : '--' ) );
TESTS.forEach(_ => console.log( swap_nibble( _[1] ) == _[0] ? 'OK' : '--' ) );

function swap_nibble(_) {
  return (_>>4) | ((_&15)<<4);
}
```

### PHP
```php
<?php

$TESTS = [ [101,86],[18,33] ];

foreach($TESTS as $_ ) {
  echo swap_nibble($_[0]) == $_[1] ? 'OK' : '--',"\n";
  echo swap_nibble($_[1]) == $_[0] ? 'OK' : '--',"\n";
}

function swap_nibble($_) {
  return ($_>>4) | (($_&15)<<4);
}
```

### Python
```python
TESTS=[[15,240],[165,90]]

def swap_nibbles(_):
  return (_>>4)|((_&15)<<4)

for t in TESTS:
  print( 'OK' if swap_nibbles(t[0])==t[1] else 'Not OK' )
  print( 'OK' if swap_nibbles(t[1])==t[0] else 'Not OK' )

```
### CESIL

Thought I'd throw in a slightly curve ball - CESIL "*Computer Education in Schools Instructional Language*" written by ICL was the
first language I was formally taught - back in the days when you had to learn how computers worked at bare bones. So it had a
reduced instruction set with just 14 commands - ADD/SUBTRACT/MULTIPLY/DIVIDE, IN/LOAD/STORE, JUMP/JIZERO/JINEG, PRINT/OUT/LINE & HALT. The layout
of code is "structured" with 8 character indent as it was designed to be stored/run on punch-cards... {The reason the "input" appears after a card
with % in it}.

CESIL was designed to teach "machine-code" to Computer science students - so other than the "I/O" commands everything else was at a basic operation level.

**Note:** Interestingly in just 26 lines of code - all 14 of the instructions are used...!

```
        LINE
Next    IN
        JINEG End
        OUT
        PRINT " => "
        STORE a
        IN
        STORE c
        LOAD a
        DIVIDE 16
        STORE b
        MULTIPLY -16
        ADD a
        MULTIPLY 16
        ADD b
        OUT
        PRINT " : "
        SUBTRACT c
        JIZERO Ok
        PRINT "--"
        JUMP Line
Ok      PRINT "OK"
Line    LINE
        JUMP Next
End     LINE
        HALT
        %
        240
        15
        15
        240
        0
        0
        255
        255
        99
        54
        -1
```
### Side note... an intepreter for CESIL...

Didn't like the idea of relying on JAVA... so here is a bare bones
interpreter... This uses a dispatch table to execute the commands
- a list of "anonymous" subroutines stored in a hash.

```perl

use strict;
use warnings;

$| = 1;   # Set auto-flush...
## Initialize state
my($MAX_LOOPS, $ptr, $reg, @in, %mem, @code, %ptrs) = (1e6,0,0);

## Define error messages
my %messages = (
  'i' => 'No further input',
  'd' => 'Division by zero ',
  'm' => 'Unitialized memory at ',
  'l' => 'Unknown pointer ',
);

## Support functions
sub _err { die sprintf "\n** %s%s [cmd %s - line %d]\n",
  $messages{$_[0]}, $code[$ptr][1], $code[$ptr][0], 1+$ptr; }
sub _j { exists$ptrs{$_}?($ptr=$ptrs{$_}-1):_err 'l'; }
sub _v { /^-?\d+$/?$_:exists$mem{$_}?$mem{$_}:_err 'm'; }

## Command dispatch table
my %commands = (
'LINE'    ,sub{print "\n"},
'OUT'     ,sub{print $reg},
'PRINT'   ,sub{print s/^"//r=~s/"$//r},
'IN'      ,sub{@in?($reg=shift@in):_err 'i'},
'STORE'   ,sub{$mem{$_}=$reg},
'LOAD'    ,sub{$reg=_v},
'ADD'     ,sub{$reg+=_v},
'SUBTRACT',sub{$reg-=_v},
'MULTIPLY',sub{$reg*=_v},
'DIVIDE'  ,sub{$_=_v;$reg=$_?int($reg/$_):_err 'd'},
'JINEG'   ,sub{_j if $reg<0},
'JIZERO'  ,sub{_j if !$reg},
'JUMP'    ,sub{_j},
'HALT'    ,sub{exit},
);

## Parser loop
while(<>) {
  ((@in = map {/^\s+-?\d+\s*$/?0+$_:()} <> ),last) if m{^ {8}%};
  ($ptrs{$1},$_)=(scalar @code,$2) if m{^(\S{1,7})\s+(.*)};
  my($cmd,$data) = split m{\s+}, s{^\s+}{}r=~s{\s+$}{}r, 2;
  die "\n** Unknown command [cmd $cmd - line ",1+@code,"]\n"
    unless exists $commands{$cmd};
  push @code, [$cmd,$data||''];
}

## Execution loop
($commands{$code[$ptr][0]}($_=$code[$ptr][1]),$ptr++)
  while --$MAX_LOOPS && $ptr<@code;

## Error if did not exit with HALT..
die "\n** Exited without HALT\n" if $ptr >= @code;
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
the counter if the number has two adjacent 1s.

```perl
sub no_11_array {
  my( $n, $ptr, @v ) = ( shift, undef, 0 );
  for( my $i = 0; $i < $n; ) {
    for( $ptr = $#v; $ptr>-1 && ++$v[$ptr]>3; $ptr--) {
      $v[$ptr]=1;
    }
    unshift @v,1 if $ptr < 0;
    $i++ unless "@v"=~m{1 1};
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

### Making the code more *readable*....

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

Although the code is "cleaner" performance is affected - it is about half the speed of the optimal (array) solution but still 4 times as fast as the (non-regex) filter method.
```perl
package Three;

use overload '++' => 'incr';
use overload '""' => 'str';

sub new {
  return bless [], 'Three';
}

sub has_double_one {
  my( $f, @v ) = @{$_[0]};
  ( $f == 1 && $v[0] == 1 ) ? ( return 1 ) : ( $f = shift @v ) while @v;
  return 0;
}

sub incr {
  my($v,$ptr) = (shift,-1);
  for( $ptr = $#$v; $ptr>-1 && ++$v->[$ptr]>3; $ptr--) {
    $v->[$ptr]=1;
  }
  unshift @{$v}, 1 if $ptr < 0;
}

sub str {
  return join '',@{$_[0]};
}


1;
```
