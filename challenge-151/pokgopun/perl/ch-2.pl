use strict;
use warnings;

my $debug = 0;

my @sample = @ARGV && join("",@ARGV) =~ /^\d+$/ ? ([@ARGV]) : ([2,4,5], [4, 2, 3, 6, 5, 3]);

foreach my $valuables (@sample) {
	my @valuables = @$valuables;
	my @robs;
	&rob([0],[1..@valuables-1],\@robs);
	
	#use Data::Dumper;
	#print Dumper \@rob;
	
	my @rob;
	my $rob_values;
	my $rob_amount = 0;
	foreach (@robs){
	
		my $rob = join(" + ", @valuables[@$_]);
		my $amount = eval($rob);
	
		#print "$rob = $amount\n\n";
	
		if ($amount > $rob_amount) {
			$rob_amount = $amount;
			$rob_values = $rob;
			@rob = @$_;
		}
	}
	
	if ($debug) {
		$valuables[$_] .= '*' foreach @rob;
	}
	printf "Input: \@valuables = (%s) %s\n", join(", ",@valuables), $debug ? "=> $rob_values" : "";
	#printf "%s\n", $rob_values if $debug == 1;
	printf "Output: %d\n\n", $rob_amount;
}

sub rob{
	my($c,$e,$rob) = @_;
	if (@$e < 2){
		#printf "%s\n", join " ", @$c;
		push @$rob, $c;
	} else {
		for (my $i=1; $i <= 2; $i++){
			my @et = @{$e}[$i..@$e-1];
			last unless @et;
			my @ct = @$c;
			push @ct, shift(@et);
			rob([@ct],[@et],$rob);
		}
	}
}
