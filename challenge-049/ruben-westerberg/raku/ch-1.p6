#!/usr/bin/env raku

my ($num, $factor)=(@*ARGS[0]//55,1);
$factor++ until ($num*$factor) ~~ /^<[01]>+$/;
printf "Smallest multiple: %d\n",$num*$factor;
