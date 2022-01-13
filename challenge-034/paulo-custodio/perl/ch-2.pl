#!/usr/bin/perl

# Challenge 034
#
# Task #2
# Contributed by Dave Cross
# Write a program that demonstrates a dispatch table.

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
