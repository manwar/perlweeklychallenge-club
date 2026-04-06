#!/usr/bin/env perl
# Perl weekly challenge 368
# Task 1:  Make it Bigger
#
# See https://wlmb.github.io/2026/04/06/PWC368/#task-1-make-it-bigger
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 N0 D0 N1 D1...
    to remove character Dn from number Nn yielding the maximum result.
    FIN
for my($number, $digit)(@ARGV){
    try {
	die "Expected a string of digits; $number" unless $number=~/^\d+$/;
	die "Expected a single digit; $digit" unless $digit=~/^\d$/;
	my @digits = split "", $number;
	my $index;
	splice @digits, $index, 1 if defined($index=which($digit, @digits));
	my $result=join "", @digits;
	say "number=$number, digit=$digit -> $result";
    }
    catch($e){warn $e;}
}

sub which($digit, @digits){ # Find which digit to remove
    my $last_found;
    for(0..@digits - 1){
	if($digits[$_] == $digit){
	    $last_found = $_;
	    return $_ if($digits[$_+1]//$digit) >= $digits[$_];
	}
    }
    $last_found;
}
