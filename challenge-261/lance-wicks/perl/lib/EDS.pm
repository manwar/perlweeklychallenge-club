package EDS;

use strict;
use warnings;

sub absolute_diff {
    my $self = shift;
    my @ints = @_;
    my $diff = 0;

    my $element_sum = $self->element_sum(@ints);
    my $digit_sum   = $self->digit_sum(@ints);

    $diff = $element_sum - $digit_sum;

    return $diff;
}

sub element_sum {
    my $self = shift;
    my @ints = @_;
    my $sum  = 0;
    for my $int (@ints) {
        $sum += $int;
    }

    return $sum;
}

sub digit_sum {
    my $self = shift;
    my @ints = @_;
    my $sum  = 0;

    for my $int (@ints) {
        for my $d ( split '', $int ) {
            $sum += $d;
        }
    }

    return $sum;
}

1;
