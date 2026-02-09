#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @smaller = smaller_than_current(@ARGV);
say join ", ", @smaller;

sub smaller_than_current {
    my(@n) = @_;
    my @smaller;
    for my $i (0 .. $#n) {
        my $count = 0;
        for my $j (0 .. $#n) {
            next if $i == $j;
            $count++ if $n[$j] <= $n[$i];
        }
        push @smaller, $count;
    }
    return @smaller;
}
