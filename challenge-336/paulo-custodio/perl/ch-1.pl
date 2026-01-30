#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say equal_groups(@ARGV) ? "true" : "false";

sub gcd {
    my ($a, $b) = @_;
    while ($b) {
        ($a, $b) = ($b, $a % $b);
    }
    return $a;
}

sub equal_groups {
    my(@nums) = @_;
    return 0 if @nums < 2;

    # count occurences of each number
    my %count;
    $count{$_}++ for @nums;

    # find GCD of all counts
    my @counts = values %count;
    my $res = shift @counts;

    for my $c (@counts) {
        $res = gcd($res, $c);
        last if $res == 1; # if GCD is 1, there is no split possible
    }

    # return true if GCD is at least 2
    return $res >= 2;
}
