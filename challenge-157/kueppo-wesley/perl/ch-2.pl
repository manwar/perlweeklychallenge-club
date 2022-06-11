#!/usr/bin/env perl

use strict;
use warnings;

use Math::BigInt;

print "Input: ";
my $n = <STDIN>;

if ($n > 2) {
    my($x, $count, $did) = (Math::BigInt->new($n), 0, 0);
    foreach (2..$n - 2) {
    	my $n_in_base__ = $x->to_base($_);
    	if ($n_in_base__ =~ /^(.)\g1{1, }$/) {
    		print "Output: 0\nSince $n" if (! $did);
    		print "\tin base $_ is $n_in_base__\n";
    		$did++;
    	}
    }
    print "Output : 1\n" if ($did == 0);
}
