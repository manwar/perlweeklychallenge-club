use strict; use warnings;
use List::Util qw(min uniq);
use Algorithm::Combinatorics qw(combinations);

sub pairs              { combinations( [uniq @_], 2 ) }
sub is_strong_pair     { my($x,$y)=@_; 0 < abs($x-$y) < min($x,$y) }
sub strong_pairs       { grep is_strong_pair(@$_), &pairs }
sub strong_pairs_count { 0 + &strong_pairs }
    
#---------------------------------------- tests
use Test::More tests=>2;
ok strong_pairs_count( @{$$_{input}} ) == $$_{output}
  for { input  => [1, 2, 3, 4, 5],
        output => 4 }, # Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)
      { input  => [5, 7, 1, 7],
        output => 1 };
