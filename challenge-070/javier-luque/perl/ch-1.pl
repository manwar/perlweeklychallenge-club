#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;

say swap_chars('perlandraku', 3, 4);

sub swap_chars {
	my ($S, $C, $O) = @_;
	my @s = split('', $S);
	my $N = scalar(@s) - 1;

	for (my $i = 1; $i <= $C; $i++) {
		my $temp           = $s[$i % $N];
		$s[$i % $N]        = $s[($i + $O) % $N];
		$s[($i + $O) % $N] = $temp;
	}

	return join '', @s;
}
