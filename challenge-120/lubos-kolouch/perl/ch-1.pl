#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #120
#               Task 1 - Swap Odd/Even bits
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 20210710 04:44:33 PM
#===============================================================================

use strict;
use warnings;

sub bin2dec {
    # shamelessly copied from The Perl Cookbook
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

sub swap_bits{
    my $what = shift;

    my $binary_what = sprintf ("%b",$what);
    $binary_what = "0".$binary_what if length($binary_what) % 2 == 1;
    my @array = ( $binary_what =~ m/../g );

    # I'm puzzled why the simple map { reverse $_ } @array did not work,
    # but it gave me back the original strings...
    my @rev_array = map { $_ = reverse $_ } @array;

    return bin2dec(join "", @rev_array);
}

use Test::More;

is(swap_bits(101), 154);
is(swap_bits(18), 33);

done_testing;

