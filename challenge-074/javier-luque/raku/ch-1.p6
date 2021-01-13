# Test: perl6 ch-1.p6
use Test;

sub MAIN() {
	is majority_element((1, 2, 2, 3, 2, 4, 2)), 2, '(1, 2, 2, 3, 2, 4, 2)';
	is majority_element((1, 3, 1, 2, 4, 5)), -1, '(1, 3, 1, 2, 4, 5)';
	done-testing();
}

sub majority_element(@A) {
	my %counts;
	@A.map({ %counts{$_}++ });

	# Majority element
	my $m = %counts.keys
	               .sort({ %counts{$^b} <=> %counts{$^a} })
	               .first;


	return (%counts{$m} > floor(@A.elems/2)) ??
		$m !! -1;
}
