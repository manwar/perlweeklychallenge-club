#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

{   my $COMPLEX = qr/^(-?[0-9.]+)\+\(?(-?[0-9.]+)\)?i$/;
    sub complex_number($num1, $num2) {
        my ($A, $B) = $num1 =~ $COMPLEX;
        my ($C, $D) = $num2 =~ $COMPLEX;
        my $r = $A * $C - $B * $D;
        my $i = $A * $D + $B * $C;
        $i = "($i)" if $i < 0;
        return "$r+${i}i"
    }
}

use Test::More tests => 5;

is complex_number('1+1i', '1+1i'), '0+2i', 'Example 1';
is complex_number('1+(-1)i', '1+(-1)i'), '0+(-2)i', 'Example 2';
is complex_number('0+3i', '0+4i'), '-12+0i', 'Example 3';
is complex_number('3+4i', '3+(-4)i'), '25+0i', 'Example 4';
is complex_number('50+(-20)i', '-10+30i'), '100+1700i', 'Example 5';


