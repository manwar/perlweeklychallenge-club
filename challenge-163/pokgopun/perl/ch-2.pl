use strict;
use warnings;

my @sample = @ARGV > 0 && join("",@ARGV) =~ /^\d+$/ ? ([@ARGV]) : ([1,2,3,4,5],[1,3,5,7,9]);
foreach (@sample){
	printf "Input: \@n = (%s)\nOutput: %d\n\n", join(", ",@$_), msaSum(@$_);
}

sub msaSum{
	while (@_ > 1){
		shift;
		$_[$_] += $_[$_-1] foreach 1..@_-1;
	}
	return shift;
}

