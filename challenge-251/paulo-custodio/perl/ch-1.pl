#!/usr/bin/env perl

use Modern::Perl;

my @ints = @ARGV;
say sum_concat(@ints);

sub sum_concat {
    my(@ints) = @_;
    my $sum = 0;
    while (@ints > 1) {
        my $n = $ints[0] . $ints[-1];
        $sum += $n;
        pop @ints; shift @ints;
    }
    $sum += $ints[0] if @ints;
    return $sum;
}
