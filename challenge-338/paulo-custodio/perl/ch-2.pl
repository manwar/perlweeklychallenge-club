#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(max);

my @arr1 = split ' ', scalar(<>);
my @arr2 = split ' ', scalar(<>);
say max_distance(\@arr1, \@arr2);

sub max_distance {
    my($a1, $a2) = @_;
    my $max_distance = 0;
    for my $i (0 .. $#$a1) {
        for my $j (0 .. $#$a2) {
            my $distance = abs($a1->[$i] - $a2->[$j]);
            $max_distance = max($max_distance, $distance);
        }
    }
    return $max_distance;
}
