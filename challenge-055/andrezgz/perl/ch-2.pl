#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/
# Task #2
#
# Wave Array
# Any array N of non-unique, unsorted integers can be arranged into a wave-like array such that
# n1 >= n2 <= n3 >= n4 <= n5 and so on.
#
# For example, given the array [1, 2, 3, 4], possible wave arrays include [2, 1, 4, 3] or [4, 1, 3, 2],
# since 2 >= 1 <= 4 >= 3 and 4 >= 1 <= 3 >= 2. This is not a complete list.
#
# Write a script to print all possible wave arrays for an integer array N of arbitrary length.
#
# Notes:
# When considering N of any length, note that the first element is always greater than or equal to the second,
# and then the <=, >=, <=, ... sequence alternates until the end of the array.

use strict;
use warnings;

my @initial = grep { /^\d+$/ } @ARGV;
die "USAGE: $0 <n1> <n2> ...\n" if @initial != @ARGV || @initial < 2;

my %waves;#hash for unique solutions when array has non-unique numbers
populate_waves( \@initial );
for (sort keys %waves) {
    print '[', join( ',', @{ $waves{$_} } ) ,']' . $/;
}

sub populate_waves {
    my $numbers = shift;
    my $perm = shift // [];

    if (!@$numbers){
        my $key = join '-',@$perm;
        $waves{$key} = [@$perm] if is_wave($perm);
        return;
    }

    foreach (0 .. @$numbers-1) {
        my $c = splice @$numbers, $_, 1;
        push @$perm, $c;
        populate_waves($numbers, $perm);
        pop @$perm;
        splice @$numbers, $_, 0, $c;
    }
    return;
}

sub is_wave {
    my $p = shift;
    for (1 .. @$p -1) {
        if ($_ % 2 == 1) {
            return if $p->[$_] > $p->[$_-1];
        }
        else {
            return if $p->[$_] < $p->[$_-1];
        }
    }
    return 1;
}

__END__

./ch-2.pl 1 2 3 4
[2,1,4,3]
[3,1,4,2]
[3,2,4,1]
[4,1,3,2]
[4,2,3,1]

./ch-2.pl 1 3 3 4
[3,1,4,3]
[3,3,4,1]
[4,1,3,3]
[4,3,3,1]
