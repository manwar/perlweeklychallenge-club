#!/usr/bin/perl
use strict;
use warnings;

sub unique_sum {

    my ($nums) = @_;

    die "Expected array reference" unless ref $nums eq 'ARRAY';

    my %count;
    $count{$_}++ for (@$nums);

    my $sum = 0;

    for my $n (keys %count) {
        $sum += $n if $count{$n} == 1;
    }

    # Alternative:
    # $sum += $_ for (grep { $count{$_} == 1} keys %count);

    # Alternative, but less readable
    # Note that this works because ($count{$_} == 1) evaluates to 1 or
    # '' (0 in numeric context).
    # $sum += $_ * ($count{$_} == 1) for keys %count;

    return $sum;
}

# Tests

my @int;

@int = (2, 1, 3, 2);
print unique_sum(\@int), "\n"; # Output: 4

@int = (1, 1, 1, 1);
print unique_sum(\@int), "\n"; # Output: 0

@int = (2, 1, 3, 4);
print unique_sum(\@int), "\n"; # Output: 10
