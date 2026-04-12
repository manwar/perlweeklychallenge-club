#!/usr/bin/perl
use strict;
use warnings;

sub all_integers {

    my ($arr) = @_;
    for my $x (@$arr) {
        return 0 unless defined $x && $x =~ /^-?\d+$/;
    }
    return 1;
}

sub dot_product {
    my ($a, $b) = @_;
    die "Invalid input: both integer arrays must have the same length\n"
        unless ref $a eq 'ARRAY'
            && ref $b eq 'ARRAY'
            && @$a == @$b
            && all_integers($a)
            && all_integers($b);

    my $sum = 0;
    for my $i (0 .. $#$a) {
        $sum += ($a->[$i] * $b->[$i]);
    }
    return $sum;
}

# Tests

my @a, @b);

# Example 1
@a = qw/1 2 3/;
@b = qw/4 5 6/;
print dot_product(\@a, \@b), "\n"; # Output: 32
