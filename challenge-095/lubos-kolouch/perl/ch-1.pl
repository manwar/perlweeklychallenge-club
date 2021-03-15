#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 095
#               Task1
#               Palindrome Number
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/16/2021 10:12:20 AM
#===============================================================================

use strict;
use warnings;
use 5.010;

sub is_palindrome {
    my $what = shift;

    # int to cover cases like 00010
    return 1 if int($what) eq reverse int($what);
    return 0;
}

use Test::More;

is(is_palindrome(1221), 1, 'Test 1221');
is(is_palindrome(-101), 0, 'Test -101');
is(is_palindrome(90), 0, 'Test 90');
is(is_palindrome('00001221'), 1, 'Test 00001221');

done_testing;
