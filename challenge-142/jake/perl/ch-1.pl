#!/usr/bin/env perl

use warnings;
use strict;
use feature 'say';

###
# You are given positive integers, $m and $n.
# Write a script to find total count of divisors of $m having last digit $n.
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-142/#TASK1
###


my $num = <STDIN>;
chomp $num;
my $last_dig = <STDIN>;
chomp $last_dig;

# output
my @divisors = count_divisors( 1, $num );
my @res = filter_last_digit ( $last_dig, \@divisors );
say scalar ( @res );

# collect numbers with specific last digit
sub filter_last_digit {
    my ( $last_dig, $divisors ) = @_;

    # courtesy ccntrq
    my @result = grep { substr( $_, -1 ) == $last_dig } @$divisors ;
    return @result;
}

sub count_divisors {
    my ( $divisor, $num ) = @_;
    my @divisors;

# divide num through all numbers <= num and count every time modulo is 0
# each time modulo is 0 we know it's a divisor
    while ( $divisor <= $num ) {
        #$div_cntr++ if $num_atr->{num} % ( $num_atr->{num} - $divisor ) == 0;
        push @divisors, $divisor if $num % $divisor == 0;
        $divisor++;
    }

    #according to the task the number itself is not considered a divisor, so we cut it off of the result
    splice( @divisors, -1 );
    return @divisors;
}