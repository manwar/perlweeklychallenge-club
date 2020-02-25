#!/usr/bin/env perl6

put (0..19).map({ "n: $_ l: "~l($_)}).join("\n");

sub l($i) {
	state @cache=(1,1);
	@cache.push(@cache[*-1,*-2].sum+1) while !@cache[$i].defined;
	@cache[$i];
}

