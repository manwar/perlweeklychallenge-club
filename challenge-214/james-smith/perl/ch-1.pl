#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [1,2,4,3,5], '5 4 S B G' ],
  [ [8,5,6,7,4], 'G 4 B S 5' ],
  [ [3,5,4,2],   'B G S 4'   ],
  [ [2,5,2,1,7,5,1], '4 S 4 6 G S 6' ],
  [ [9,17,13,15,17,6,2,7,18,12,16,18,15,19,3,14,4,14,18,19,11,13,5,15,7,8,1,9,20,13,10,17,17,19,8,14,4,1,18,7],
    '26 9 20 14 9 33 38 30 5 23 13 5 14 S 37 17 35 17 5 S 24 20 34 14 30 28 39 26 G 20 25 9 9 S 28 17 35 39 5 30' ],
);


## First a "one-liner" - we get the rank of each node as
## the number of entries with a score greater than value
## (+1)...
## We then just map 1,2,3 to G S B using the arrayref
## defaults to "n" if it is not 1/2/3.

sub rank {
  map { ['','G','S','B']->[$_] || $_ }
  map { //; 1 + grep { $_ > $' }  @_ }
  @_
}

## Faster solution - 
## (1) We sort the numbers into order - BUT
## keep a track of their position, and add a rank
## column
## (2) We loop through each element of the array,
## the rank is the position in the array (+1) if
## the number is different from the previous number
## otherwise it is the rank of the previous number!
## (3) We now have to revert this back the correct
## order - we do this by sorting on the position
## index we created in (1)... We then map 1,2,3 to
## G,S,B as above...

sub rank2 {
  my $pos = 0;
  @_ = sort { $b->[0] <=> $a->[0] }
       map  { [$_,$pos++,1]       }
            @_;
  $_[$_][2] = $_[$_][0] == $_[$_-1][0]
            ? $_[$_-1][2]
            : $_ + 1                   for 1..$#_;
  map  {  ['','G','S','B']->[$_->[2]] || $_->[2] }
  sort { $a->[1] <=> $b->[1]                     }
       @_
}


is( "@{[rank( @{$_->[0]} )]}", $_->[1] ) for @TESTS;
is( "@{[rank2( @{$_->[0]} )]}", $_->[1] ) for @TESTS;
done_testing();
