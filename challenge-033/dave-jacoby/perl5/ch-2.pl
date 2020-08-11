#!/usr/bin/env perl

use strict ;
use warnings ;
use utf8 ;
use feature qw{ postderef say signatures state } ;
no warnings qw{ experimental::postderef experimental::signatures } ;

##  Formatted Multiplication Table
##  Write a script to print 11x11 multiplication table, only the top half triangle.
##
##    x|   1   2   3   4   5   6   7   8   9  10  11
##  ---+--------------------------------------------
##    1|   1   2   3   4   5   6   7   8   9  10  11
##    2|       4   6   8  10  12  14  16  18  20  22
##    3|           9  12  15  18  21  24  27  30  33
##    4|              16  20  24  28  32  36  40  44
##    5|                  25  30  35  40  45  50  55
##    6|                      36  42  48  54  60  66
##    7|                          49  56  63  70  77
##    8|                              64  72  80  88
##    9|                                  81  90  99
##   10|                                     100 110
##   11|                                         121
##

my $done ;

say '   x|   1   2   3   4   5   6   7   8   9  10  11';
say '----+--------------------------------------------';

for my $i ( 1 .. 11 ) {
    print join '', ( ' ' x ( 4 - length $i ) ), $i, '|' ;
    for my $j ( 1 .. 11 ) {
        my $ij = join '', sort $i, $j ;
        my $p  = $i * $j ;
        my $pp = '' ;
        $pp = $p unless $done->{ $ij }++ ;
        my $pad = ' ' x ( 4 - length $pp );
        print $pad . $pp ;
        }
    say '' ;
    }
