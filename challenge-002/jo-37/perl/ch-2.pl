#!/usr/bin/perl

use Test2::V0;
use Math::Utils 'moduli';
use List::Util 'reduce';

my @b35 = (0 .. 9, 'A' .. 'Y');
my %b35 = map {($b35[$_] => $_)} 0 .. $#b35;

sub to_b35 {
	join '', map $b35[$_], reverse moduli(shift, 35);	
}

sub from_b35 {
	reduce {$a * 35 + $b35{$b}} 0, split //, shift;
}

is to_b35(0), '0';
is to_b35(9), '9';
is to_b35(10), 'A';
is to_b35(34), 'Y';
is to_b35(35), '10';
is from_b35(to_b35(7**$_)), 7**$_ for 1 .. 18;

done_testing;
