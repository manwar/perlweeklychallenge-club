#!/usr/bin/env perl6
use v6;

sub trcol(Str $s) {
    my @cols=(|('A'..'Z'), |(2..*).map({ |(['A'..'Z'] xx $_).reduce(&infix:<X~>) }));
    given $s {
	when /^<[a..zA..Z]>+$/ {
	    @cols.first({ $_ eq $s.uc }, :k)+1
	}
	when /^\d+$/ {
	    @cols.[$s.Int-1]
	}
    }
}

say @*ARGS[0].&trcol

# run as <script> <input: either a pos. integer or an alphabetic column label>
