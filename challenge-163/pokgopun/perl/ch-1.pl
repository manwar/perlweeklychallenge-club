use strict;
use warnings;

my @sample = @ARGV > 1 && join("",@ARGV) =~ /^\d+$/ ? ([@ARGV]) : ([1,2,3],[2,3,4]);
foreach (@sample){
	printf "Input: \@n = (%s)\nOutput: %d\n\n", join(", ",@$_), sumBitwise(@$_);
}

sub sumBitwise{
	my $sum;
	while(@_){
		my $i = shift;
		$sum += $i & $_ foreach @_;
	}
	return $sum;
}
