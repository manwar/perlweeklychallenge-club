#!/usr/bin/env perl
#
# ch-2.pl - Print first 20 gapful numbers
#           Ref: https://oeis.org/A108343
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

say for first_n_gapful(shift // 20);

sub is_gapful(_) { $_ = pop; not $_ % join '', (split '')[0,-1] }

# Print the first n gapful numbers
sub first_n_gapful {
    my $N = shift;
    my @r;
    for ($_ = 100; @r < $N; $_++) {
        push @r, $_ if is_gapful;
    }
    @r;
}
