#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use experimental qw<signatures>;

# Reverse the last two nybbles, without limiting $n to < 256.
sub nib ( $n ) {
    return   ($n & 0xFFFFFF00)
         + ( ($n & 0xF0) >> 4 )
         + ( ($n & 0x0F) << 4 );
}

my @in = @ARGV ? @ARGV : (101, 18, 253, 254, 255, 256, 257);
say $_, " ==> ", nib($_) for @in;
