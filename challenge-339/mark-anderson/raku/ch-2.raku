#!/usr/bin/env raku
use Test;

is peak-point(<  -5   1  5  -9  2   >),  1;
is peak-point(<  10  10 10 -25      >), 30;
is peak-point(<   3  -4  2   5 -6 1 >),  6;
is peak-point(<  -1  -2 -3  -4      >),  0;
is peak-point(< -10  15  5          >), 10;

sub peak-point(+@gain)
{
    max [\+] 0, |@gain     
}
