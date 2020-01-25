#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ sum };

use constant {
    NOTHING => 0,
    PLUS    => 1,
    MINUS   => 2
};

my @digits = 1 .. 9;

my %op = ( (NOTHING) => "",
           (PLUS)    => '+',
           (MINUS)   => '-');

sub apply {
    my ($mask) = @_;
    return $digits[0]
        . join "",
          map $op{ $mask->[$_-1] } . $digits[$_],
          1 .. $#digits
}

sub evaluate {
    my ($expression) = @_;
    my @terms = $expression =~ /[-+]?[0-9]+/g;
    return sum(@terms)
}

sub increment {
    my ($mask) = @_;
    my $i = $#$mask;
    $mask->[$i--] = NOTHING while $mask->[$i] == MINUS;
    ++$mask->[$i];
}

my @mask = (NOTHING) x (@digits - 1);
while (1) {
    my $expression = apply(\@mask);
    say $expression if 100 == evaluate($expression);
    last unless grep $_ != MINUS, @mask;
    increment(\@mask);
}

# Verify by piping the output to bc.
