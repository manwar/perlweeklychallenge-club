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
  my( $s, @q, %n, %d ) = ( shift, [my $e = shift] );
  for my $r (@_) { ## Compute neighbour map.
    $n{ $r->[$_-1] }{ $r->[$_]   } =
    $n{ $r->[$_]   }{ $r->[$_-1] } = 1 for 1..$#$r;
  }
  while( my $p = shift @q ) {
    $d{$p->[0]}=1;
    $_==$s ? return ($_,@{$p}) : push @q, [$_,@{$p}]
      for grep{ !$d{$_} } keys %{$n{$p->[0]}};
  }
  ()
}

is( "@{[shortest_route( @{$_->[0]} )]}", $_->[1] ) for @TESTS;
done_testing();
