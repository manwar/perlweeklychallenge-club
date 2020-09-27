#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge Task 1
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#               Count set bits
#
#       AUTHOR: Lubos Kolouch
#===============================================================================

use strict;
use warnings;

sub get_dec2bin {
    my $what = shift;

    my $count;

    for (1..$what) {
        my $str = unpack("B32", pack("N", $_));
        $count += () = $str =~ /1/g;
    }

    return $count % 1_000_000_007;
}

use Test::More;

is(get_dec2bin(4), 5, 'Test 4');
is(get_dec2bin(3), 4, 'Test 3');

done_testing;


