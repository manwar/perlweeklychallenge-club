#!/usr/bin/perl
use 5.40.1;
use warnings;

sub parseNumber ($formula, $position) {
	my $start = ${$position};

	while (${$position} < length($formula) &&
	substr($formula, ${$position}, 1) =~ /\d/) {
        ${$position}++ 
    }

	return ${$position} == $start
		? 1
		: substr($formula, $start, ${$position} - $start);
}

sub parseGroup ($formula, $position) {
	my %atoms;

	while (${$position} < length($formula) &&
    substr($formula, ${$position}, 1) ne q{)}) {
		my %group;

		if (substr($formula, ${$position}, 1) eq q{(}) {
			${$position}++;
			%group = %{parseGroup($formula, $position)};
			${$position}++;
		} else {
			my $start = ${$position}++;
            while (${$position} < length($formula) &&
            substr($formula, ${$position}, 1) =~ /[a-z]/) {
			    ${$position}++;
            }
			my $element = substr($formula, $start, ${$position} - $start);
			$group{$element} = 1;
		}

		my $multiplier = parseNumber($formula, $position);
        for (keys %group) {
		    $atoms{$_} += $group{$_} * $multiplier;
        }
	}

	return \%atoms;
}

my ($formula) = @ARGV;

my $position = 0;
my $atoms = parseGroup($formula, \$position);

say join q{}, map { $_ . ($atoms->{$_} > 1 ? $atoms->{$_} : q{}) }
	sort keys %{$atoms};

