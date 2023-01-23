[< Previous 199](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-199/james-smith) |
[Next 201 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-201/james-smith)

# The Weekly Challenge 200

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-200/james-smith

# Task 1: Arithmetic Slices

***You are given an array of integers. Write a script to find out all Arithmetic Slices for the given array of integers. An integer array is called arithmetic if it has at least 3 elements and the differences between any three consecutive elements are the same.***

## Solution

There are a number of solutions.. I will start with the first "optimal" one I have... if I have time I'll write up a more compact one.
```perl
sub a_slices {
  ## Less than 1 value return...
  return unless $#_;
  ## Set start of sequence to 0, d - the difference between entry 1 and entry 0
  my($st,$d,@pairs)=(0,$_[1]-$_[0]);
  ## Loop through all end points
  for(my$en=1;$en<@_;$en++) {
    ## If the gap is different - update gap (and start) and continute through loop
    if($_[$en]-$_[$en-1] != $d) {
      ($st,$d)=($en-1,$_[$en]-$_[$en-1])
    ## If it is the same add it and all alternative entries
    } else {
      ## We only store the start/end of the runs not the whole sequence
      push( @pairs, map { [$_,$en] } $st..$en-2 );
    }
  }
  ## Now we find all the start ends and return the series of each of these subsequences.
  return [ map { [ @_[ $_->[0] .. $_->[1] ] ] } @pairs ];
}
```

# Task 2: Seven Segment 200

***A seven segment display is an electronic component, usually used to display digits. The segments are labeled 'a' through 'g' as shown: The encoding of each digit can thus be represented compactly as a truth table:***
```
my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
```
***For example, `$truth[1] = ‘bc’`. The digit 1 would have segments ‘b’ and ‘c’ enabled.***

## Solution

```perl
my @truth = qw(abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg);
my @blank = map { '    ' } 0..6;

## A mapper for segment to what to draw... The rows are represented by pairs of bits 0->blank, 1->LHS, 2->RHS, 3->bar
my %parts = ( 'a' => 0x0003, 'b' => 0x0028, 'c' => 0x0a00, 'd' => 0x3000, 'e' => 0x0500, 'f' => 0x0014, 'g' => 0x00c0, );
## The four "pictures"!
my @parts = ( '    ', '|   ', '   |', ' -- ' );

sub display {
  ## Grab number & initialise output as empty.
  my( $n, @out ) = ( shift, map {''} @blank );
  while( $n ) {
    ## Get the last digit & set the display for the digit to blank.
    my( $d, @dig ) = ( $n%10, @blank );
    ## Use our truth table along with part mapping to generate values for each number
    for my $bar ( map { $parts{$_} } split //, $truth[$d] ) {
      $dig[ $_ ] |= $parts[ $bar&3 ], $bar >>= 2 for 0 .. $#blank
    }
    ## Add to the display...
    $out[ $_ ] = $dig[ $_ ].' '.$out[ $_ ] for 0..$#blank;
    ## Update N...
    $n = int( $n / 10 );
  }
  ## Render!
  say for @out;
}```
