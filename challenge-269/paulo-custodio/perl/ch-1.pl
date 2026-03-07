#!/usr/bin/env perl

use Modern::Perl;

say trailing_zero(@ARGV) ? 'true' : 'false';

sub trailing_zero {
    my(@ints) = @_;
    my $count_trailing_zero = grep {($_ & 1) == 0} @ints;
    return $count_trailing_zero >= 2;
}
