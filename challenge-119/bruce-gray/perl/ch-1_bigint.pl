#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use experimental qw<signatures>;
use bigint;

# Reverse the last two nybbles, without limiting $n at all.
sub nib ( $n ) {
    return   ($n & ~0xFF)
         + ( ($n &  0xF0) >> 4 )
         + ( ($n &  0x0F) << 4 );
}

my @tests = (
    # All numbers written in hex, to make clearer the correctness of the expected transformation.
    # The Raku and Perl tests differ for >=256, since they different interpretations what it means to expand the problem past 256.
    [ 0x65 => 0x56 ], # 101 ==>  86
    [ 0x12 => 0x21 ], #  18 ==>  33
    [  0x1 => 0x10 ],
    [    0 =>    0 ],
    [ 0xDeadBeef => 0xDeadBefe ],
    [  0xBadBeef =>  0xBadBefe ],
    # # Larger than  64-bits; # Even and odd number of nybbles.
    [ 0x19_Efface_Decade_Facade => 0x19_Efface_Decade_Facaed ],
    [  0x9_Efface_Decade_Facade =>  0x9_Efface_Decade_Facaed ],

    # Larger than 128-bits; # Even and odd number of nybbles.
    [ 0x19_BeefCafe_FeedFace_BeefCafe_FeedFace => 0x19_BeefCafe_FeedFace_BeefCafe_FeedFaec ],
    [  0x9_BeefCafe_FeedFace_BeefCafe_FeedFace =>  0x9_BeefCafe_FeedFace_BeefCafe_FeedFaec ],
);

if (@ARGV) {
    say $_, " ==> ", nib($_) for @ARGV;
}
else {
    for (@tests) {
        my ( $x,  $y  ) = @{$_};
        my ( $nx, $ny ) = map { nib($_) } @{$_};
        say $x, " ==> ", $nx;
        say $y, " ==> ", $ny;
        die "$x != $ny" if $x != $ny;
        die "$y != $nx" if $y != $nx;
    }
    say 'OK';
}
