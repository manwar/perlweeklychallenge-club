#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use utf8;

my %op = ( '+' => sub { $_[0] + $_[1] },
           '−' => sub { $_[0] - $_[1] },
           '×' => sub { $_[0] * $_[1] },
           '÷' => sub { $_[0] / $_[1] });

sub rpn {
    my ($input) = @_;
    my @tokens = split ' ', $input;
    my @stack;
    for my $token (@tokens) {
        if ($token =~ /^[0-9]+$/) {
            push @stack, $token;
        } else {
            push @stack, $op{$token}->(((pop @stack) // die 'Stack empty'),
                                       (pop @stack) // die 'Stack empty');
        }
    }
    my $result = pop @stack;
    die "Left on stack: @stack" if @stack;

    return $result
}

my $input = '15 7 1 1 + − ÷ 3 × 2 1 1 + + −';
my $expected_result = 5;
my $result = rpn($input);
die unless $result == $expected_result;
say $result;

