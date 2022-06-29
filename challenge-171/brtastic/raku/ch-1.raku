#!/usr/bin/env raku

sub get-divisors (Int $for-number) returns Iterable
{
	return gather {
		for 1 .. $for-number / 2 -> $current {
			take $current if $for-number %% $current;
		}
	}
}

sub MAIN() {
	my $list = (1 .. *).hyper.grep({ !($_ %% 2) && get-divisors($_).sum > $_ });
	say $list[^20];
}

