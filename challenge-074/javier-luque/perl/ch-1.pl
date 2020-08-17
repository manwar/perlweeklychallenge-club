#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;
use POSIX qw/ floor /;
use Test::More;

is majority_element(1, 2, 2, 3, 2, 4, 2), 2, '(1, 2, 2, 3, 2, 4, 2)';
is majority_element(1, 3, 1, 2, 4, 5), -1, '(1, 3, 1, 2, 4, 5)';
done_testing;

sub majority_element {
	my %counts;
	map { $counts{$_}++ } @_;

	# Majority element
	my ($m) = sort { $counts{$b} <=> $counts{$a} }
	          keys %counts;

	return ($counts{$m} > floor(scalar(@_)/2)) ?
		$m : -1;
}
