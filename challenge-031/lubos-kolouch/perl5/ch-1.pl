#!/usr/bin/env perl
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-031/
#
#  Create a function to check divide by zero error without checking if the denominator is zero.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 10/26/2019 07:10:56 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use Try::Tiny;

sub divide_test {
    my ( $num, $div ) = @_;

    my $result;

    try {
        $result = $num / $div;
    }
    catch {
        $result = "ERROR";
    }
    finally {
        return $result;
    }
}

# TESTS
use Test::More;

is(divide_test( 0,0 ),"ERROR");
is(divide_test( 1,0 ),"ERROR");
isnt(divide_test( 1,1 ),"ERROR");

done_testing;

