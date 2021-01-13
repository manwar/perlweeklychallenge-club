#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @list = ( 10, 4, 1, 8, 12, 3 );
my @indices = ( 0, 2, 5 );

map { state $i = 0; $list[$indices[$i++]] = $_; }
    sort { $a <=> $b }
        map { $list[$_] }
            @indices;

say join q{ }, @list;

