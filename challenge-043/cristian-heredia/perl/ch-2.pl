#!/usr/bin/perl

use strict;
use Math::Base::Convert;
use Math::Base::Convert qw(:base);

my $valor;

for (my $b = 7; $b <= 10; $b++) {

	$valor = ($b - 4) * $b**($b - 1) + 2 * $b ** ($b-2) + $b**($b-3) + $b**3;
	
	$converted = cnv($valor,10 => $b); 
	print "Base is $b, and the result is $converted\n";

}


