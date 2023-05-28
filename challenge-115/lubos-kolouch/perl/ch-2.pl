use strict;
use warnings;
use feature 'say';

sub largest_multiple {
    join '', sort { $b cmp $a } grep { $_ % 2 == 0 } @_;
}

# Test
say largest_multiple( 1, 0, 2, 6, 9, 4, 5 );    # Output: 6420
