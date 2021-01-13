#!/usr/bin/env raku

my $n=@*ARGS[0]//3;
my $number=(1.rand.round xx $n).join: "";
say "Testing on: $number";
my $maxSize=-1;
my @max;
loop (my $l=0;$l < $n; $l++) {
	loop (my $r=$l;$r < $n;$r++) {
		my $str=$number;
		tr/10/01/ given $str.substr-rw($l,$r-$l+1);
		given (m:g/1/ given $str ).Int {
			when $maxSize {
				push @max, [$l,$r];
			}

			when ($_>$maxSize) {
				@max=[[$l,$r],];
				$maxSize=$_;
			}
			default {

			}
		}
	}
}
say "Maximal 1's of count $maxSize given by L/R pairs:";
say @$_.join: ", " for @max;

