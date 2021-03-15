#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 001
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-001/
#               Task 2 - FizzBuzz
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/23/2021 03:36:54 PM
#===============================================================================

use strict;
use warnings;

sub fizz_buzz {
    my $what = shift;

    my @output;

    for (1..20) {
        
        my $line = '';

        $line = 'fizz' if $_ % 3 == 0;
        $line .= 'buzz' if $_ % 5 == 0;
        $line = $_ unless $line;

        push @output, $line;
    }

    return \@output;
}

use Test::More;

is_deeply(fizz_buzz(), [1, 2, 'fizz', 4, 'buzz', 'fizz', 7, 8, 'fizz', 'buzz', 11, 'fizz', 13, 14, 'fizzbuzz', 16, 17, 'fizz', 19, 'buzz']);
done_testing;

