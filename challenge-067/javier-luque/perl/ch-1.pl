#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;
use Algorithm::Combinatorics qw(combinations);

# Default $m and $n
my $m = shift // 5;
my $n = shift // 2;

# Answers
my @combinations = numeric_combinations($m, $n);
say answer_to_string(\@combinations);

sub numeric_combinations {
	my ($m, $n) = @_;
	my @data = (1 .. $m);

	# Possible combinations
	return my @all_combinations
		= combinations(\@data, $n);
}

# Flaten to answer array to a string
sub answer_to_string {
	my $combinations = shift;
	return
	'[ ' .
		(
			join ', ',
			map {
				'[' .
				(join ', ', @$_) .
				']'
			} @$combinations
		) .
	' ]';
}
