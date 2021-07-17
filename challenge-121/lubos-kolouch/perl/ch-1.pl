#!/usr/bin/perl 
#===============================================================================
#  DESCRIPTION: Perl Weekly Challenge #121
#               Task 1 -Invert Bit
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 20210717 04:44:33 PM
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

sub bin2dec {
    # shamelessly copied from The Perl Cookbook
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

sub invert_bit{
    my ($what, $n) = @_;

    my $binary_what = sprintf ("%b",$what);
    my @binary_arr = split //, $binary_what;
    $binary_arr[-$n] = $binary_arr[-$n] ? 0 : 1;
    return bin2dec(join "", @binary_arr);
}

use Test::More;

is(invert_bit((12, 3)), 8);
is(invert_bit((18, 4)), 26);

done_testing;

