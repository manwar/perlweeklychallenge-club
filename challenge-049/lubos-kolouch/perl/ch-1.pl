#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/
#
#  TASK #1
#  Smallest Multiple
#
#   Write a script to accept a positive number as command line argument and print the smallest multiple of the given number consists of digits 0 and 1.
#
#   For example:
#   For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/29/2020 08:38:26 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;


sub find_multiple_0_1 {
    my $input = shift;

    my $count = 0;

    while ($input !~ /^[01]+$/) {
        $input += $input;
        # for some numbers there is probably no result, so let's just return -1
        return -1 if $count == 1000;
        $count++;
    }

    return $input;
}

my $what = $ARGV[0];

say find_multiple_0_1($what);

use Test::More;

is(find_multiple_0_1(55),110);
done_testing;
