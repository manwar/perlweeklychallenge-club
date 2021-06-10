use v5.30;
use warnings;
use List::Util qw(all sum0);

use constant EL_COUNT => 7;

sub permute
{
	my (@what) = @_;

	return [@what] if @what == 1;

	my @options;

	for my $el (@what) {
		my $seen = 0;
		push @options, map {
			[$el, @$_]
		} permute(grep {
			$_ != $el || $seen++
		} @what);
	}

	return @options;
}

sub four_squares
{
	my (@input) = @_;
	my @results;

	return @results if @input != EL_COUNT;

	for my $case (permute @input) {
		my @real_case = (0, @$case, 0);
		my @summed_groups = map {
			sum0 map { $real_case[$_] } $_ .. $_ + 2
		} grep {
			$_ % 2 == 0 && $_ <= @real_case - 2
		} keys @real_case;

		my $letter = 'a';
		push @results, {map { $letter++, $_ } @$case}
			if all { $_ == @summed_groups[0] } @summed_groups;
	}

	return @results;
}

use Data::Dumper;
say Dumper([four_squares 1 .. 7]);

