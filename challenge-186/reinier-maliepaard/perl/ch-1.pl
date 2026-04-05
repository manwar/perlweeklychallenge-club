#!/usr/bin/perl
use strict;
use warnings;

sub zip {

    my ($a, $b) = @_;
    die "Invalid input: both arrays must have the same length\n"
        unless ref $a eq 'ARRAY' && ref $b eq 'ARRAY' && @$a == @$b;

    my @res = map {$a->[$_], $b->[$_]} 0..$#$a; # clearer but slightly verbose: scalar(@$a) - 1
    return @res;

}

# Alternative

sub zip_alt {

    my ($a, $b) = @_;
    die "Invalid input: both arrays must have the same length\n"
        unless ref $a eq 'ARRAY' && ref $b eq 'ARRAY' && @$a == @$b;

    my @res;
    # Replaced map form previous version with a for loop
    # arguably clearer for side-by-side pairing.

    for my $i (0 .. $#$a) {
        push @res, $a->[$i], $b->[$i];
    }
}

# Tests
my (@a, @b);

# Example 1
@a = qw/1 2 3/;
@b = qw/a b c/;
print zip(\@a, \@b), "\n"; # Output: (1 a 2 b 3 c)

# Example 2
@a = qw/1 2 3/;
@b = qw/a b c/;
print zip(\@b, \@a), "\n"; # Output: (a 1 b 2 c 3)
