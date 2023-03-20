package main;
use strict;
use warnings;


sub find_duplicate_in_sequence
{
	my($aref) = @_;

	my %hash = ();

	foreach my $element  (@{$aref})  {
		if(!exists $hash{$element}) {
			$hash{$element} = 1;
		} else {
			return $element;
		}
	}

	return -1;
}

sub find_missing_in_sequence
{
	my($aref) = @_;

	my $previous_number = $aref->[0];
	my $first_number = $previous_number;

	foreach my $current_number ( @{$aref} ) {
		if($current_number != $first_number) {
			if($current_number != $previous_number + 1) {
				return $previous_number + 1;
			} else {
				$previous_number = $current_number;
			}
		}
	}

	return -1;
}

sub find_missing_and_duplicate_in_sequence
{
	my ($aref) = @_;

	my $duplicate	= find_duplicate_in_sequence($aref);
	my $missing	= find_missing_in_sequence($aref);	

	return ($duplicate, $missing);
}

print "(" . join(",", find_missing_and_duplicate_in_sequence([1,2,2,4])) . ")\n";
print "(" . join(",", find_missing_and_duplicate_in_sequence([1,2,3,4])) . ")\n";
print "(" . join(",", find_missing_and_duplicate_in_sequence([1,2,3,3])) . ")\n";

1;

