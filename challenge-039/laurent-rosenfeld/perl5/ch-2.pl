#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Test::More tests => 5;

my %operations = (
    '+' => sub { return $_[0] + $_[1]; },
    '-' => sub { return $_[0] - $_[1]; }, # hyphen
    '−' => sub { return $_[0] - $_[1]; }, # minus
    'x' => sub { return $_[0] * $_[1]; },
    '*' => sub { return $_[0] * $_[1]; },
    '×' => sub { return $_[0] * $_[1]; },
    '/' => sub { return $_[0] / $_[1]; },
    '÷' => sub { return $_[0] / $_[1]; },
);

sub parse_operation {
    my @stack;
    for my $token (split /\s+/, shift) {
        if ($token =~ /^\d+$/) {
            push @stack, $token ;
        } elsif (exists $operations{$token}) {
            return "Invalid RPN expression" if @stack < 2;
            my $op2 = pop @stack;
            my $op1 = pop @stack;
            push @stack, $operations{$token}->($op1, $op2);
        } else {
            die "Invalid token $token.";
        }
    }
    return $stack[0]
}
is parse_operation("1 2 +"), 3, "2 operands";
is parse_operation("1 2 + 4 ×"), 12, "3 operands, a Unicode multiplication operator";
is parse_operation("1 2 + 4 * 5 + 3 -"), 14, "5 operands";
is parse_operation("3 4 5 x -"), -17, "Start with 3 operands and then two operators";
is parse_operation("15 7 1 1 + − ÷ 3 × 2 1 1 + + −"), 5, "8 operands, 4 Unicode operators";
