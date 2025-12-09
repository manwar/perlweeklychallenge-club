#!/usr/bin/env perl
# Perl weekly challenge 351
# Task 1:  Special Average
#
# See https://wlmb.github.io/2025/12/08/PWC351/#task-1-special-average
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to obtain the special averages (the average after eliminating the minimum
    and maximum values) of arrays Sn, where Sn are strings that represent the
    arrays of the form "[V0 V1...]" and where Vn are numbers.
    FIN
for(@ARGV){
    try {
	my $in=pdl($_);
	my ($min, $max)=$in->minmax;
	my $trimmed=$in->where(($in!=$max)&($in!=$min));
	say "$_ -> ", $trimmed->nelem?$trimmed->avg:"0 or NaN?"; # average of 0 element array?
    }
    catch($e){
	warn $e;
    }
}
