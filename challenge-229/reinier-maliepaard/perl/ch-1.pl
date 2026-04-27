#!/usr/bin/perl
use strict;
use warnings;

sub lexicographic_order {

    my ($aref) = @_;

    # Validate that all input strings are lowercase
    for (@$aref) {
        die "Input '$_' must be lowercase.\n" if ($_ ne lc $_);
    }

    my $count = 0;
    for (@$aref) {
        my $asc = join('', sort split(//, lc $_));
        my $desc = reverse $asc;
        $count ++ if ($asc ne $_) && ($desc ne $_);
    }
    return $count;
}

# Tests

my @arr;

# Example 1
@arr = ("abc", "bce", "cae");
print lexicographic_order(\@arr), "\n"; # Output: 1

# Example 2
@arr = ("yxz", "cba", "mon");
print lexicographic_order(\@arr), "\n"; # Output: 2
