#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use Math::Fibonacci;

my $input = shift @ARGV;
chomp $input;

die "Invalid input, enter numbers greater than 0.\n" if $input < 0;

my @sums;
foreach my $num (0 ... $input / 2) {
    my $diff = $input - $num;
    push @sums, [$diff, $num];
}

sub is_fib { return Math::Fibonacci::isfibonacci(@_) }

foreach (@sums) {
    next unless is_fib($_->[0]) and is_fib($_->[1]);
    say "$_->[0] + $_->[1]";
}
