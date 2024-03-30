use strict;
use warnings;


package Ch1;
use Carp;

sub max_positive_negative {
    my @ints = @_;
    my $positive_count = scalar(grep { $_ > 0 } @ints);
    my $negative_count = scalar(grep { $_ < 0 } @ints);
    return $positive_count > $negative_count ? $positive_count : $negative_count;
}

# Assert tests
croak "Test failed!" unless max_positive_negative(-3, 1, 2, -1, 3, -2, 4) == 4;
croak "Test failed!" unless max_positive_negative(-1, -2, -3, 1) == 3;
croak "Test failed!" unless max_positive_negative(1, 2) == 2;

1;