#!/usr/bin/perl
use 5.038;
use warnings;

sub max(@arr) {
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

sub X($arr1, $arr2) {
    my @arr1 = @{ $arr1 };
    my @arr2 = @{ $arr2 };

    return map {
        my $first = $_;
        map { 
            [ ref $first eq 'ARRAY' ? @{$first} : $first, $_ ];
        } @arr2;
    } @arr1;
}

my @arr1 = map { split q{,} } shift;
my @arr2 = map { split q{,} } shift;

say max(map { abs($_->[0] - $_->[1]) } X(\@arr1, \@arr2));