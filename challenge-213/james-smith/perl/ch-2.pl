#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ [ 1,7, [1,2,6],[5,6,7] ], '1 2 6 7' ],
 [ [ 1,7, [1,2,3],[4,5,6],[3,8,9],[7,8] ], '1 2 3 8 7' ],
 [ [ 1,4, [1,2],  [3,4]   ], '' ],
 [ [ 1,7, [1,2,3,4,5,6,7], [2,8], [8,6] ], '1 2 8 6 7' ],
 [ [ 1,15, [1..15],[2,16],[16,18,8],[9,17],[17,14] ], '1 2 16 18 8 9 17 14 15' ],
);

sub shortest_route {
  my( $s, @q, %n, %d ) = ( shift, [my $e = shift] );    ## Get start end, and initialize queue
  return $s if $s eq $e;                                ## special case - as the soln only
                                                        ## returns list of length 1 or more
  for my $r (@_) {                                      ## Compute neighbour map.
    $n{ $r->[$_-1] }{ $r->[$_]   } =                    ## We need to walk both ways along the
    $n{ $r->[$_]   }{ $r->[$_-1] } = 1 for 1..$#$r;     ## route - so we start from the 2nd
  }                                                     ## so we don't fall off the LH end
  while( my $p = shift @q ) {                           ## For each queue
    $d{$p->[0]}=1;                                      ## mark element as seen..
    $_ eq $s ? return ($_,@{$p}) : $push @q, [$_,@{$p}] ## For each new node. If it is the
      for grep{ !$d{$_} } keys %{$n{$p->[0]}};          ## start we return the list, o/w push
  }                                                     ## it to the find all neighbours of
                                                        ## the current point we haven't
                                                        ## already seen 
  ()                                                    ## Empty list - as no route
}

is( "@{[shortest_route( @{$_->[0]} )]}", $_->[1] ) for @TESTS;
done_testing();
