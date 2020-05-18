#! /usr/bin/perl

use strict;
use warnings;
use integer;

my @list=@ARGV;
unless (@list) {
  @list=(2,5,-1,3);
}

my ($mxp,$a,$b);

foreach my $ai (0..$#list) {
  foreach my $bi ($ai..$#list) {
    my $p=1;
    map {$p*=$_} @list[$ai..$bi];
    if (!defined $mxp || $p > $mxp) {
      ($mxp,$a,$b)=($p,$ai,$bi);
    }
  }
}

print join(' * ',@list[$a..$b]),' = ',$mxp,"\n";
