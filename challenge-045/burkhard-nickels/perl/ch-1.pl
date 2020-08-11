#!/usr/bin/perl

use strict;
use warnings;

print "ch-1.pl - PWC #45 Task #1: Square Secret Code\n";

my $msg = "The quick brown fox jumps over the lazy dog";
if($ARGV[0]) { $msg = $ARGV[0]; }

print "Original: $msg\n";
$msg =~ s/\s//g;
$msg = lc($msg);
my @l = split("",$msg);

my $coded_msg;
for(my $i=0; $i<=7; $i++) {
	for(my $j=$i; $j<=$#l; $j+=8) {
		$coded_msg .= $l[$j];
	}
	$coded_msg .= " ";
}
print "Coded   : $coded_msg\n";
