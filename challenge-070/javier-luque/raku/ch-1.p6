# Test: perl6 ch-1.p6
sub MAIN() {
	say swap-chars('perlandraku', 3, 4);
}

sub swap-chars( Str $S, Int $C, Int $O) {
	my $N = $S.chars;
	my @s = $S.split('', :skip-empty);

	loop (my $i = 1; $i <= $C; $i++) {
		my $temp           = @s[$i % $N];
		@s[$i % $N]        = @s[($i + $O) % $N];
		@s[($i + $O) % $N] = $temp;
	}

	return @s.join('');
}
