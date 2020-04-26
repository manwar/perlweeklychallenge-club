#!/usr/bin/env raku

my @words= <alphabet book carpet cadmium cadeau alpine>;

my @shortest=@words.map({
	my $prefix;
	for (0.. .chars-1) -> $i {
		$prefix= .substr(0,$i);
		last if $prefix eq one @words.map({ .substr(0,$i)});
	}
	$prefix;
});

say @shortest;
