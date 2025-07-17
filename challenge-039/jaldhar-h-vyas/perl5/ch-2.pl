#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use feature qw/ switch /;

unless (@ARGV) {
    die "Usage: $0 <expression>\n";
}

my @tokens = split /\s+/, shift;
my @stack;

foreach my $token (@tokens) {
    if ($token =~ /^[+-]?\d+$/) {
        push @stack, $token;
    } else {
        my $b = pop @stack;
        my $a = pop @stack;

        unless (defined $a && defined $b) {
            die "Insufficient operands for '$token'\n";
        }

        my $result;
        given ($token) {
            when '+' {  $result = $a + $b; } 
            when '-' {  $result = $a - $b; }
            when '*' {  $result = $a * $b; }
            when '/' {
                        if ($b == 0) {
                            die "Division by zero\n";
                        }
                        $result = $a / $b;
                    }
            default { die "Unknown operator: '$token'\n"; }
        }
        push @stack, $result;
    }
}

if (@stack != 1) {
    die "Invalid expression: stack contains extra values\n";
}

say $stack[0];
