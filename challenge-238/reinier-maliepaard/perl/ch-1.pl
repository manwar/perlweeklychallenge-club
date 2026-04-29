#!/usr/bin/perl
use strict;
use warnings;

sub running_sum {
    my ($int) = @_;
    my $sum = 0;
    my @res;
    for my $i (0..@$int-1) {
        $sum += $int->[$i];
        push (@res, $sum);
    }
    return @res;
}

# Tests

my @int;

# Example 1
@int = (1, 2, 3, 4, 5);
print "(", join(', ', running_sum(\@int)), ")\n"; # Output: (1, 3, 6, 10, 15)

# Example 2
@int = (1, 1, 1, 1, 1);
print "(", join(', ', running_sum(\@int)), ")\n"; # Output: (1, 2, 3, 4, 5)

# Example 3
@int = (0, -1, 1, 2);
print "(", join(', ', running_sum(\@int)), ")\n"; # Output: (0, -1, 0, 2)
