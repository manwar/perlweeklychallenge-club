use strict;
use warnings;
use List::Util qw/sum/;

my @samples = @ARGV > 3 && join("",@ARGV) =~ /^\d+$/ ? ([@ARGV]) : ([1,3,5,7,9],[1,2,3,4,5],[2,4,2]);

foreach (@samples) {
	my @sample = @$_;
	printf "Input: \@n = (%s)\n", join(", ", @sample);
	my $o = -1;
	for (my $i=1; $i < @sample-1; $i++){
		if ( sum(@sample[0..$i-1]) == sum(@sample[$i+1..@sample-1]) ){
			$o = $i;
			last;
		}
	}
	printf "Output: $o\n\n";
}

