#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

#usage : perl script 1 2 3 4

my @o=@ARGV;
push my @slc,$o[0],$o[1];
sub sayno{say "no slice found"};
sayno if scalar(@ARGV)<3;
my $fl=0;

#build slices
while(scalar(@o)>=2){
	my $delta=$o[1]-$o[0];
	for(2..$#o){push @slc,$o[$_] and say "(@slc)" and $fl=1 if($o[$_]-$o[$_-1] == $delta) || last};
	splice(@o,0,1);
	undef(@slc);push @slc,$o[0],$o[1];
}
$fl==1 ? exit : sayno;

