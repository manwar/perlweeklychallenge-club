#!/usr/bin/perl

use strict;
use warnings;

while(<DATA>){
    chomp;
    print "$_ -> ";
    s/^0+//;
    print "$_\n";
}

__DATA__
110
001
202
050
