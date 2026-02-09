#!/usr/bin/env perl

use Modern::Perl;
use Data::Dump 'dump';

@ARGV==3 or die "usage: $0 from to count\n";
my($from, $to, $count) = @ARGV;

# find shuffle pairs - register A and the number of pairs of A
my %found;
for my $A ($from .. $to) {
    for (my $k = 2; length($A*$k)==length($A); $k++) {
        my $B = $A * $k;
        if (is_shuffle_pair($A, $B)) {
            $found{$A}++;
        }
    }
}

# count how many >= count
my $num = 0;
for (values %found) {
    $num++ if $_ >= $count;
}

say $num;

sub is_shuffle_pair {
    my($a, $b) = @_;
    return 0 unless length($a)==length($b);
    my %count;
    $count{$_}++ for (split //, $a);
    $count{$_}-- for (split //, $b);
    for (values %count) {
        return if $_ != 0;
    }
    return 1;
}
