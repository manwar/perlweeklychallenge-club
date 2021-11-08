#!/usr/bin/perl

use strict;
use warnings;

my @args = (101, 18);

foreach(@args){
    printf("%4d -> %4d\n", $_, switch_bits($_));
}

exit(0);



sub switch_bits{

    return(
        # Bits raised
        (($_[0] << 1) & 0xAA)
        |
        # Bits lowered
        (($_[0] >> 1) & 0x55)
    );

}



