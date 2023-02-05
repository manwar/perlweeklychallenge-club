use strict;
use warnings;
use v5.36;

use List::MoreUtils qw(slideatatime all);
use Const::Fast;

sub has_three_consecutive_odds {
  const my $step_size => 1;
  const my $window_size => 3;
  my $it = slideatatime $step_size, $window_size, @_;
  my @vals;
  while (@vals = $it->() and @vals == $window_size) {
    return 1 if all { $_ % 2 } @vals;
  }
  return 0;
}

say has_three_consecutive_odds 1, 5, 3, 6;
say has_three_consecutive_odds 2, 6, 3, 5;
say has_three_consecutive_odds 1, 2, 3, 4;
say has_three_consecutive_odds 2, 3, 5, 7;
