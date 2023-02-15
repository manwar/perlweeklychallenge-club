use strict;
use warnings;
use v5.36;

use List::MoreUtils qw(slide);
use List::Util qw(none);

use Test::More;

sub is_monotonic_array (@array) {
  my @diffs = slide { $a <=> $b } @array;
  # Perl is returning '' instead of 0 ?
  return (none { $_ == -1 } @diffs) || (none { $_  == 1 } @diffs) ? 1 : 0;
}

is is_monotonic_array (1,2,2,3), 1;
is is_monotonic_array (1,3,2),   0;
is is_monotonic_array (6,5,5,4), 1;

done_testing;
