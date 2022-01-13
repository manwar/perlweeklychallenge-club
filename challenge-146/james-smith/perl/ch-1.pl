#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my($c,@p)=(5,3);
for(;@p<10000;$c+=2){
  ($_*$_>$c)?((push@p,$c),last):$c%$_||last for@p;
}
say$p[-1];
