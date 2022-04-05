#!/usr/bin/env perl

# Challenge 039
#
# TASK #2
# Contributed by Andrezgz
# Write a script to demonstrate Reverse Polish notation(RPN). Checkout the wiki
# page for more information about RPN.

use Modern::Perl;

# simple rpn calculator
my @stack;
my %dispatch = (
    '+' => sub { my $b = pop @stack; my $a = pop @stack; push @stack, $a+$b; },
    '-' => sub { my $b = pop @stack; my $a = pop @stack; push @stack, $a-$b; },
    '*' => sub { my $b = pop @stack; my $a = pop @stack; push @stack, $a*$b; },
    '/' => sub { my $b = pop @stack; my $a = pop @stack; push @stack, $a/$b; },
    '.' => sub { say pop @stack; },
);

for (split //, "@ARGV") {
    if (/\s/) {}
    elsif (/\d/) { push @stack, $_; }
    elsif (exists $dispatch{$_}) { $dispatch{$_}->(); }
    else { die "invalid operation: $_"; }
}
