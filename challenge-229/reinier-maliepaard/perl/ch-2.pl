#!/usr/bin/perl
use strict;
use warnings;

# Strategy:
#
# 1. Build a temporary hash from @a, @b, @c
# 2. Duplicates collapse automatically
#
#    Example:
#    map { $_ => 1 } @a creates a list like: (1 => 1, 2 => 1, 4 => 1)
#    duplicates will be overwritten
#
# 3. Get unique elements via keys: keys %{ ... }
# 4. Increment %count once per unique element: $count{$_}++

sub two_out_of_three {

    my ($a, $b, $c) = @_;

    my %count;

    $count{$_}++ for keys %{ { map { $_ => 1 } @$a } };
    $count{$_}++ for keys %{ { map { $_ => 1 } @$b } };
    $count{$_}++ for keys %{ { map { $_ => 1 } @$c } };

    my @res = grep { $count{$_} >= 2 } keys %count;

    return sort @res;
}

# Tests

my (@a, @b, @c);

# Example 1
@a = qw/1 1 2 4/;
@b = qw/2 3/;
@c = qw/4/;
print "(", join(', ', two_out_of_three(\@a, \@b, \@c)), ")\n"; # Output: (2, 4)

# Example 2
@a = qw/4 1/;
@b = qw/2 4/;
@c = qw/1 2/;
print "(", join(', ', two_out_of_three(\@a, \@b, \@c)), ")\n"; # Output: (1, 2, 4)
