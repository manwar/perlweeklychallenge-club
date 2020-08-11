#!/usr/bin/env perl
use strict;
use warnings;

my ($num, $factor)=($ARGV[0]//55,1);
$factor++ until  ($num*$factor) =~ /^[01]+$/;
printf "Smallest multiple: %d\n",$num*$factor;
