#!/home/chuck/rakudo/bin/perl6

use strict;

# print "ch-2.p6 - PWC #45 Task #2: Source Dumper\n";
# print $*PROGRAM, ", ", $*PROGRAM-NAME, "\n";

my $fh = open :r, $*PROGRAM;

my $str;
while ( ! $fh.eof; ) { 
	$str = $fh.get;
	$str.print; print "\n"; 
}
$fh.close;

