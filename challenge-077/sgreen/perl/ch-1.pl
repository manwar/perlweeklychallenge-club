#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'sum';

sub find_fibonacci_numbers {
    my $max = shift;
    return (1) if $max == 1;

    my @numbers = ( 1, 2 );
    while ( my $sum = $numbers[-2] + $numbers[-1] ) {
        last if $sum > $max;
        push @numbers, $sum;
    }
    return @numbers;
}

sub main {
    my $N = shift;

    # Sanity check
    die "Please provide the value\n" unless $N;
    die "The number must be a positive integer\n"
      unless $N =~ /^\d+$/ and $N > 0;

    my @stash             = ();
    my @fibonacci_numbers = find_fibonacci_numbers($N);

    # Work backwards through the fibonacci numbers
    foreach my $num ( reverse @fibonacci_numbers ) {
        # Find the remainder of the numbers left
        my $remainder = sum (grep { $_ < $num } @fibonacci_numbers ) // 0;

        # Add the current number to each existing values, but only if
        #  the new sum is <= $N, and the remainer ($N - sum) <= $remainder
        push @stash,
          grep { my $sum = sum(@$_); $sum <= $N and $N - $sum <= $remainder }
          ( [$num], map { [ @$_, $num ] } @stash );
    }

    my @solutions = grep { sum(@$_) == $N } @stash;

    # Display the result
    say "RESULT IS ", scalar(@solutions);
    foreach my $solution (@solutions) {
          say join( ' + ', @$solution ), " = $N";
    }
}

main(@ARGV);
