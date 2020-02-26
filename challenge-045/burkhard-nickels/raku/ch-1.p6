#!/home/chuck/rakudo/bin/perl6

use strict;

print "ch-1.p6 - PWC #45 Task #1: Square Secret Code\n";

my $msg = "The quick brown fox jumps over the lazy dog";
if (@*ARGS[0]) { $msg = @*ARGS[0]; }

print "Original: $msg\n";
$msg ~~ s:g/\s//;
$msg = $msg.lc;
# print "Debug: $msg\n";
my @l = split("",$msg);
# print join("-",@l), "\n";

my $coded_msg;
for (1 .. 8) {
	loop (my $j = $_; $j <= @l.end; $j += 8) {
		# print "($j) @l[$j] ";
		$coded_msg ~= @l[ $j ];
	}
	$coded_msg ~= " ";
}
print "Coded   : $coded_msg\n";

