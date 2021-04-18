#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);
#part 1
my $stepF = 1.8;

my $f = -148;
print "F:\tC\n";
for (my $c=-100;$c <= 100; $c++ ){
	print int $f,": $c\n" if $f==$c;
	$f = sprintf "%.1f", $f+$stepF;
}


