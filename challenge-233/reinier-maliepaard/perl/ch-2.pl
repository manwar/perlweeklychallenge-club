#!/usr/bin/perl
use strict;
use warnings;

sub frequency_sort {
    my (@array) = @_;

    my %count;

    $count{$_}++ for (@array);

    my @res;

    foreach my $c (sort { $count{$a} <=> $count{$b} || $b <=> $a} keys(%count)) {
        push @res, ($c) x $count{$c};
    }
    return @res;
}

# Tests

my @ints;

# Example 1
@ints = (1, 1, 2, 2, 2, 3);
print "(", join(', ', frequency_sort(@ints)), ")\n"; # Output: (3,1,1,2,2,2)

# Example 1
@ints = (2, 3, 1, 3, 2);
print "(", join(', ', frequency_sort(@ints)), ")\n"; # Output: (1,3,3,2,2)

# Example 3
@ints = (-1, 1, -6, 4, 5, -6, 1, 4, 1);
print "(", join(', ', frequency_sort(@ints)), ")\n"; # Output: (5,-1,4,4,-6,-6,1,1,1)
