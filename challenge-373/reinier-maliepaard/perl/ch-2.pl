#!/usr/bin/perl
use strict;
use warnings;

...the real complexity was the formatting :-)

sub list_division {
    my ($n, @list) = @_;

    return -1 if $n > @list || $n <= 0;

    my $d = int(@list / $n);
    my $r = @list % $n;

    my @groups;

    for my $i (0 .. $n - 1) {

        my $size = $d + ($i < $r);

        push @groups, '(' . join(',', splice(@list, 0, $size)) . ')';
    }

    return '(' . join(', ', @groups) . ')';
}

my @list;
my $n;

# Example 1
@list = (1,2,3,4,5,6);
$n = 3;
print list_division($n, @list), "\n"; # Output: ((1,2), (3,4), (5,6))

# Example 2
@list = (1,2,3,4,5);
$n = 2;
print list_division($n, @list), "\n"; # Output: ((1,2,3), (4,5))

# Example 3
@list = (1,2,3);
$n = 2;
print list_division($n, @list), "\n"; # Output: ((1,2), (3))

# Example 4
@list = (1,2,3,4,5,6,7,8,9,10);
$n = 5;
print list_division($n, @list), "\n"; # Output: ((1,2), (3,4), (5,6), (7,8), (9,10))

# Example 5
@list = (1,2,3);
$n = 4;
print list_division($n, @list), "\n"; # Output: -1

# Example 6
@list = (72,57,89,55,36,84,10,95,99,35);
$n = 7;
print list_division($n, @list), "\n"; # Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))
