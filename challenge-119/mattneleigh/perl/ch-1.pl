#!/usr/bin/perl

use strict;
use warnings;

my @args = (101, 18);

foreach(@args){
    printf("%4d -> %4d\n", $_, swap_nibbles($_));
}

exit(0);



sub swap_nibbles{

    return(
        # New most significant nibble
        (($_[0] << 4) & 0xF0)
        |
        # New least significant nibble
        (($_[0] >> 4) & 0x0F)
    );

}



