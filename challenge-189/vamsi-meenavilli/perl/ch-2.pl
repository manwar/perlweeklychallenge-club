#!/usr/bin/perl

=head1

Week 189:
	https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #2: Array Degree
	You are given an array of 2 or more non-negative integers.
	Write a script to find out the smallest slice, i.e. contiguous subarray of the original array, having the degree of the given array.
	The degree of an array is the maximum frequency of an element in the array.

=cut

use Test::More;

is_deeply(_GetSmallestSliceOfArrayDegree((1, 3, 3, 2)), [3, 3], 'Example 1');
is_deeply(_GetSmallestSliceOfArrayDegree((1, 2, 1, 3)), [1, 2, 1], 'Example 2');
is_deeply(_GetSmallestSliceOfArrayDegree((1, 3, 2, 1, 2)), [2, 1, 2], 'Example 3');
is_deeply(_GetSmallestSliceOfArrayDegree((1, 1, 2, 3, 2)), [1, 1], 'Example 4');
is_deeply(_GetSmallestSliceOfArrayDegree((2, 1, 2, 1, 1)), [1, 2, 1, 1], 'Example 5');

sub _GetSmallestSliceOfArrayDegree {
	my @array = @_;

	my $degree_of_array = _GetDegreeOfArray(@array);

	return [sort @array]->[0] if $degree_of_array == 1;

	my $array_size = scalar @array;
	my %degree_array_slices_sum_map = ();

	for (my $i = 0; $i < $array_size; $i++) {
		my @array_slice = ($array[$i]);

		for (my $j = $i + 1; $j < $array_size; $j++) {
			push @array_slice, $array[$j];

			if (_GetDegreeOfArray(@array_slice) == $degree_of_array) {
				my $array_slice_sum = 0;

				foreach my $element (@array_slice) {
					$array_slice_sum += $element;
				}

				$degree_array_slices_sum_map{$array_slice_sum} = [@array_slice];
				break;
			}
		}

	}

	return $degree_array_slices_sum_map{[sort keys %degree_array_slices_sum_map]->[0]};
}

sub _GetDegreeOfArray {
	my @array = @_;

	my $degree = 0;
	my %element_degree_map = ();

	foreach my $element (@array) {
		if (exists $element_degree_map{$element}) {
			$element_degree_map{$element} += 1;
		}
		else {
			$element_degree_map{$element} = 1;
		}
	}

	return $element_degree_map{[sort {$element_degree_map{$a} <=> $element_degree_map{$b}} keys %element_degree_map]->[-1]};
}

done_testing();
