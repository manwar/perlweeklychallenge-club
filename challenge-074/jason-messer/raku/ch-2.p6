
use v6;

my $S1 = 'ababc';
my $S2 = 'xyzzyx';

sub fnr(Str $s) {
	my @left;
	gather BUILD: for $s.comb -> $strch {
		@left.unshift($strch);
		for @left -> $ch {
			if @left.grep($ch).elems == 1 {
				take $ch;
				next BUILD;
			}
		}
		take '#';
	}
}

multi MAIN() {
	say fnr($S1).join;
	say fnr($S2).join;
}

multi MAIN(Str $S) {
	say fnr($S).join;
}
