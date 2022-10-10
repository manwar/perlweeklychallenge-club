#!perl.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-10-03
# Challenge 185  Mac Address ( Perl )

use strict;
use warnings;
use feature "say";

my @inp = ("1ac2.34f0.b1c2", "abc1.20f1.345a");

for (@inp) {

  my $inp_numalpha = (join '', split '\.', $_);     # remove periods from string

  my $x = 0;

  my $outstr = '';

  while($x < length($inp_numalpha)) {

    $outstr .= substr($inp_numalpha,$x,2).":";      # print groups of two with ":"

    $x += 2;                                        # bump offset by 2

  }

  chop($outstr);                                    # remove trailing ":"

  say $outstr;

}
