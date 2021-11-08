#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #119
#               Task 1 - Swap Nibbles
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 07/04/2021 04:44:33 PM
#===============================================================================

use strict;
use warnings;

sub bin2dec {
    # shamelessly copied from The Perl Cookbook
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

sub reverse_nibbles {
    my $what = shift;

    my $binary_what = sprintf ("%b",$what);

    my $first_part = sprintf("%04d", substr $binary_what, 0, -4);
    my $second_part = sprintf("%04d", substr $binary_what, -4);

    my $reversed_binary = $second_part . $first_part;
    return bin2dec($reversed_binary);
}

use Test::More;

is(reverse_nibbles(101), 86);
is(reverse_nibbles(18), 33);

done_testing;

