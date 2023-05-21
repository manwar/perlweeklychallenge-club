#!/usr/bin/perl
use strict;
use warnings;

sub find_peaks {
    my @arr = @_;
    my $n   = scalar @arr;

    my @peaks;
    push @peaks, $arr[0] if $arr[0] > $arr[1];

    for my $i ( 1 .. $n - 2 ) {
        push @peaks, $arr[$i] if $arr[$i] > $arr[ $i - 1 ] and $arr[$i] > $arr[ $i + 1 ];
    }

    push @peaks, $arr[-1] if $arr[-1] > $arr[-2];

    return @peaks;
}

# Tests
print join( ", ", find_peaks( 18, 45, 38, 25, 10, 7, 21, 6,  28, 48 ) ), "\n";    # 48, 45, 21
print join( ", ", find_peaks( 47, 11, 32, 8,  1,  9, 39, 14, 36, 23 ) ), "\n";    # 47, 32, 39, 36
