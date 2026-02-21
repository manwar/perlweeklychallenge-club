#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @peeks = find_peeks(@ARGV);
say "(", join(", ", @peeks), ")";

sub find_peeks {
    my(@n) = @_;
    return (0) if @n < 3;
    my @peeks;
    for my $i (1 .. $#n-1) {
        if ($n[$i] > $n[$i-1] && $n[$i] > $n[$i+1]) {
            push @peeks, $i;
        }
    }
    return (0) if @peeks==0;
    return @peeks;
}
