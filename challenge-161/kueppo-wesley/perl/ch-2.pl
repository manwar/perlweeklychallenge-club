#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';
#use Test;

my $p;
my $pv = q();
my @pangram;

while ( <ARGV> ) {
    chomp;
    $p = join '', sort( split //, join '', @pangram, $_ );
    $p =~ s/ (.) \g1 * /$1/gx;
    push @pangram, $_ if length $p > length $pv;
    $pv = $p;
    if (length $p == 26) {
    	#say "$p";
    	say "@pangram"; say '';
    	@pangram = ();
    	$pv = q();
    }
}
