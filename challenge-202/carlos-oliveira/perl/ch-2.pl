use strict;
use warnings;
use v5.36;

use Const::Fast;
use List::MoreUtils qw(slideatatime firstidx slide all);

sub pick_widest_valley {
  return @_ if @_ < 3;
  const my $step_size => 1;
  for my $window_size (reverse 3 .. @_) {
    my $it = slideatatime $step_size, $window_size, @_;
    my @vals;
    while (@vals = $it->() and @vals == $window_size) {
        # where the non-increasing part necessarily stops? we'll start after it
        my $abyss = firstidx { $_ } slide { $a < $b } @vals;
        $abyss++;
        return @vals
          # firstidx returns -1 when an element is not found, 0 after our increment:
          # this slice only has the non-increasing part and either part can be empty
          if $abyss == 0
            # the $abyss can't be the last element because the slide function needs at least two elements
            || $abyss == $#vals
            # everything after the $abyss must be non-decreasing
            || all { $_ } slide { $a <= $b } @vals[$abyss..$#vals];
    }
  }
  # any two elements shall suffice if the windows above didn't solve
  return @_[0,1];
}

say join ", ", pick_widest_valley 1, 5, 5, 2, 8;
say join ", ", pick_widest_valley 2, 6, 8, 5;
say join ", ", pick_widest_valley 9, 8, 13, 13, 2, 2, 15, 17;
say join ", ", pick_widest_valley 2, 1, 2, 1, 3;
say join ", ", pick_widest_valley 1, 3, 3, 2, 1, 2, 3, 3, 2;
say join ", ", pick_widest_valley 5, 8, 6, 2;

# see results for short lists
say join ", ", pick_widest_valley 1, 3;
say join ", ", pick_widest_valley 3, 1;
say join ", ", pick_widest_valley 3, 3;
say join ", ", pick_widest_valley 5;
say join ", ", pick_widest_valley 1, 5, 1;
say pick_widest_valley == 0 ? 'empty' : 'not empty';
