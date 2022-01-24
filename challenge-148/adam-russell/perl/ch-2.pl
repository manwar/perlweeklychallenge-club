use strict;
use warnings;
##
# Write a script to generate first 5 Cardano Triplets.
##
use POSIX;
use Algorithm::Combinatorics q/tuples/;

sub first_five_cardano_triplets{
    my @triplets;
	for my $tuple (tuples([0..100], 3)){
		my($s, $t, $u) = @{$tuple};
		if(8 * pow($s, 3) + 15 * pow($s, 2) + 6 * $s - 27 * pow($t, 2) * $u == 1){
			push @triplets, [$s, $t, $u];
		}
		return @triplets if @triplets == 5;
	}
}

MAIN:{
    for my $triplet (first_five_cardano_triplets()){
        print join(", ", @{$triplet}) . "\n";
    }
}