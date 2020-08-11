use v5.24;
use warnings;
use constant PALINDROME_MIN_SIZE => 2;

sub finder
{
	my ($string) = @_;

	my $len = length $string;
	my @found;

	for my $pos (0 .. $len - PALINDROME_MIN_SIZE) {
		for my $size (PALINDROME_MIN_SIZE .. $len - $pos) {

			my $part_size = int($size / 2);
			my $part1 = substr $string, $pos, $part_size;
			my $part2 = substr $string, $pos + $part_size + $size % 2, $part_size;

			push @found, [$pos, $size]
				if $part1 eq scalar reverse $part2;
		}
	}

	return @found;
}

sub palindrome
{
	my ($string) = @_;

	my @found = finder($string);
	my @partitions;

	while (@found > 0) {
		my $last_pos = 0;
		my @current_partition;

		for my $key (keys @found) {
			my ($pos, $size) = $found[$key]->@*;

			if ($pos >= $last_pos) {
				$last_pos = $pos + $size;
				push @current_partition, $key;
			}
		}

		push @partitions, [
			reverse map {
				my $item = $found[$_];
				splice @found, $_, 1;
				substr $string, $item->[0], $item->[1];
			} reverse @current_partition
		];
	}

	return @partitions > 0 ? \@partitions : -1;
}

use Test::More;

my @data = (
	['aabaab', [[qw(aa baab)], [qw(aabaa)], [qw(aba)], [qw(aa)]]],
	['abbaba', [[qw(abba)], [qw(bb aba)], [qw(bab)]]],
	['abca', -1],
);

for (@data) {
	my ($case, $output) = @$_;
	is_deeply(palindrome($case), $output);
}

done_testing;
