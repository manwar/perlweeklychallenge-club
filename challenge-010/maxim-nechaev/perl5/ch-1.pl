#!/usr/bin/perl -w
use strict;
use feature 'say';
use List::Util qw/first/;

sub lat2dec {
    my %l = (
	I =>    1,
	V =>    5,
	X =>   10,
	L =>   50,
	C =>  100,
	D =>  500,
	M => 1000,
    );

    my ($n, $p) = (0, 0);
    for ( reverse split '', shift ) {
	$n += $p <= $l{$_}? $l{$_} : -$l{$_};
	$p = $l{$_};
    }
    return $n;
}

sub dec2lat {
    my %d = (
	   1 => 'I',
	   4 => 'IV',
	   5 => 'V',
	   9 => 'IX',
	  10 => 'X',
	  40 => 'XL',
	  50 => 'L',
	  90 => 'XC',
	 100 => 'C',
	 400 => 'CD',
	 500 => 'D',
	 900 => 'CM',
	1000 => 'M',
    );

    my ($n, $s, $v) = (shift, '', 0);
    do {
	$v = first { $n >= $_ } sort { $b <=> $a } keys %d;
	$s .= $d{$v};
    } while $n -= $v;
    return $s;
}

say lat2dec('MCMXCIV');  # 1994
say dec2lat(2019);       # MMXIX
