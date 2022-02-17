### Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]
## Example of usage: perl %scripl% 1 5,3 2,3,4 7,1,0,2 6,4,5,2,8
#
use strict;
use warnings;
#use Data::Dumper;

my $mins = "";
while (@ARGV) {
	my $min = [sort { $a <=> $b } split(/\D/,shift)]->[0];
	#	print Dumper $min;
	$mins .= "$min ";
}
chop $mins;
my $sum;
$sum += $_ foreach split(/ /,$mins);
$mins =~ s/ /+/g;
print "Min Sum Path = $mins = $sum\n";
