#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my($N,@p2) = (@ARGV?$ARGV[0]:500,4);

for(my$c=3;$c*$c<$N;$c+=2){
  ($_>$c)?((push@p2,$c*$c),last):$c*$c%$_||last for@p2;
}

say for grep{my$t=$_;!grep{!($t%$_)}@p2}1..$N;
