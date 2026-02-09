#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums..\n";
say peek_point(@ARGV);

sub peek_point {
    my(@nums) = @_;
    my $peek = 0;
    my $pos = 0;
    for (@nums) {
        $pos += $_;
        $peek = max($peek, $pos);
    }
    return $peek;
}
