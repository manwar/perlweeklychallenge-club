#!/usr/bin/perl
use strict;
use warnings;

sub center {
	my @strings = @_;

	my $max_len = 0;
	foreach my $str (@strings) {
		if (length $str > $max_len) {
			$max_len = length $str;
		}
	}
	for my $i (0..$#strings) {
		my $space_len = ($max_len - length $strings[$i]) / 2;
		$strings[$i] =
			q{ } x $space_len . $strings[$i] . q{ } x $space_len;
	}

	return @strings;
}


print join "\n", center("This", "is", "a test of the", "center function");


__END__
