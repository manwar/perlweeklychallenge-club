#!/usr/bin/env perl

use strict;
use warnings;
use v5.26;
use bignum (a=>100);
#use Math::BigRat;
#compute Euler's number to the nth term
#
my $degree=$ARGV[0]//10;
my $i=1;
my $sum=1;#Math::BigRat->new(1/1);
while ($i <= $degree ) {
	state $fac=1;
	$sum+=1/($fac*=$i++);
}
#printf "Eulers constant to $degree terms:\n%s\n",$sum->as_float(100);
printf "Eulers constant to $degree terms:\n%s\n",$sum;
