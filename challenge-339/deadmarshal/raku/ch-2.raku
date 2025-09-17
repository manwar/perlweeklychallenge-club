#!/usr/bin/env raku

sub peak-point(@arr)
{
  ([\+] (0,|@arr)).max
}

say peak-point([-5,1,5,-9,2]);
say peak-point([10,10,10,-25]);
say peak-point([3,-4,2,5,-6,1]);
say peak-point([-1,-2,-3,-4]);
say peak-point([-10,15,5]);

