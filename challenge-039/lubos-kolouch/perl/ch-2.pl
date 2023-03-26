#!/usr/bin/perl

use strict;
use warnings;

sub evaluate_rpn {
    my ($expression) = @_;
    my @stack;

    for my $token ( split / /, $expression ) {
        if ( $token =~ /^[+\-*\/]$/ ) {
            my $b = pop @stack;
            my $a = pop @stack;

            if ( $token eq '+' ) {
                push @stack, $a + $b;
            }
            elsif ( $token eq '-' ) {
                push @stack, $a - $b;
            }
            elsif ( $token eq '*' ) {
                push @stack, $a * $b;
            }
            else {    # $token eq '/'
                push @stack, $a / $b;
            }
        }
        else {
            push @stack, $token;
        }
    }

    return $stack[0];
}

my $rpn_expression = '3 4 + 2 * 1 +';
my $result         = evaluate_rpn($rpn_expression);
print "RPN expression: $rpn_expression\n";
print "Result: $result\n";
