#!/usr/bin/env perl
#
# ch-2.pl - Self-descriptive numbers
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw< all sum >;

my @base = (0..9, 'a'..'z');
my %val  = map { $base[$_] => $_ } 0..$#base;

for my $base (@ARGV) {
    printf "base-%2d: %s\n", $base, join ', ', self_descriptive_base($base);
}

# Return true if a number is self-descriptive. Since we don't need
# to check s-d numbers in base 7 or above, there is no need to
# handle non-base10 representations here.
sub is_self_descriptive {
    my @s = split '', shift;

    return if @s != sum @s; # Not a Niven number

    my %count;
    $count{ $s[$_] }++ for 0..$#s;

    all { $count{$_} == $s[$_] } 0..$#s;
}

# Return ALL self-descriptive numbers of a given base, in that base
sub self_descriptive_base {
    my $b = shift;

    return "$base[$b-4]21" . '0' x ($b-7) . '1000' if $b >= 7;

    # For other bases, we search. See my blog for discussion.
    grep { is_self_descriptive($_) }
     map { 10 * $_ } 10**($b-2) .. 10**($b-1) - 1;
}
