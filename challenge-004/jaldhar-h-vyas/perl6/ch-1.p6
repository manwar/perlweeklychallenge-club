#!/usr/bin/perl6
# Thanks to thundergnat for the module and informing me about it on IRC.
use Rat::Precise;

my $size =  $*PROGRAM-NAME.IO.s;
π.FatRat.precise($size - 1).say; # - 1 because 3. is a digit of pi
