#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-12-16
# Week: 039

# TASK #2
# Contributed by Andrezgz
# Write a script to demonstrate Reverse Polish notation(RPN). Checkout
# the wiki page for more information about RPN.
# https://en.wikipedia.org/wiki/Reverse_Polish_notation

use strict;
use warnings;
use Test::More tests => 2;

my %dt = (
    '+' => sub { $_[0] + $_[1] },
    '-' => sub { $_[0] - $_[1] },
    'x' => sub { $_[0] * $_[1] },
    '/' => sub { $_[0] / $_[1] },
);

ok( evaluate("1 2 +") == 3 );
ok( evaluate("15 7 1 1 + - / 3 x 2 1 1 + + -") == 5 );

# for each token in the postfix expression:
#   if token is an operator:
#     operand_2 ← pop from the stack
#     operand_1 ← pop from the stack
#     result ← evaluate token with operand_1 and operand_2
#     push result back onto the stack
#   else if token is an operand:
#     push token onto the stack
# result ← pop from the stack

sub evaluate {
    my $expression = shift;
    my @expression = split " ", $expression;
    my @stack      = ();
    for my $token (@expression) {
        if ( $token =~ /\d+/ ) {
            push @stack, $token;
        }
        else {
            my $operand_2 = pop @stack;
            my $operand_1 = pop @stack;
            my $result    = $dt{$token}->( $operand_1, $operand_2 );
            push @stack, $result;
        }
    }
    return pop @stack;
}
