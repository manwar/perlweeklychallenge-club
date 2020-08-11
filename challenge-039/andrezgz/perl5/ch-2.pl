#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-039/
# Task #2
# Write a script to demonstrate Reverse Polish notation(RPN).
# Checkout the wiki page for more information about RPN.
# https://en.wikipedia.org/wiki/Reverse_Polish_notation

use strict;
use warnings;

# the order of the operands is inverted on subroutines
# for the proper operation to take place
# while allowing directly popping from @stack
# without the need of temporary variables
my $operations = {
    '+' => sub { $_[1] + $_[0] },
    '-' => sub { $_[1] - $_[0] },
    # used 'x' instead of '*'
    # because I liked the way of adding operands and operators
    # as simple command-line argument rather than using a string
    'x' => sub { $_[1] * $_[0] },
    '/' => sub { $_[1] / $_[0] },
};

my @stack;
while (my $e = shift @ARGV) {
    push @stack, $e =~ /^\d+$/ ? $e : $operations->{$e}->(pop @stack,pop @stack)
}
print @stack;

__END__

./ch-2.pl 15 7 1 1 + - / 3 x 2 1 1 + + -
5
