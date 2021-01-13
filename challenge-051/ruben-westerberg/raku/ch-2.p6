#!/usr/bin/env raku
for 100..999 {
	my @conSubs=contiguousSubs($_.Str);
	if @conSubs.unique == @conSubs {
		put "$_ is Colourful";
	}
}

sub contiguousSubs($string) {
	my $len=$string.chars;
	do for 1..$len -> $subLen {
		| do  for (0..$len-$subLen) {
				[*] $string.substr($_,$subLen).comb;
		}
	}

}
