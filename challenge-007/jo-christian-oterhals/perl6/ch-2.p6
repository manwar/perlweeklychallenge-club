#!/usr/bin/env perl6

constant $DICTIONARY = "/usr/share/dict/words";

sub MAIN(Str $word1 where * ~~ /^<lower>+$/, Str $word2 where * ~~ /^<lower>+$/, Bool :$list-all = False) {
	die "Error: The words must have equal length." if $word1.chars != $word2.chars;

	my @ladders = [];
	my @words = $DICTIONARY.IO.lines.grep({ $_ eq $_.lc && $_.chars == $word1.chars });

	create-word-ladder($word1, [ $word1 ] , {});

	for @ladders.sort( { $^a.elems cmp $^b.elems } ).kv -> $index, @ladder {
		say @ladder.join(" -> ");
		exit if !$list-all && $index == 0;
	}
	
	sub create-word-ladder(Str $word, @ladder is copy, %seen is copy) { 
		for $word.comb.kv -> $index, $character {
			my $r3 = $word.substr(0, $index) ~ "." ~ $word.substr(*-($word.chars - ($index + 1)));
			my $r5 = ( '.' x $index ) ~ $word2.substr($index,1) ~ ( '.' x $word.chars - 1 - $index) ;
			for @words.grep( / <$r3> /).grep( / <$r5> / )  -> $x {
				if ! %seen{$x}.defined && $x ne $word {
					%seen{$x} = True;
					@ladder.push($x);
					@ladders.push(@ladder) if $x eq $word2;
					create-word-ladder($x, @ladder, %seen);
				}
			}
		}
	}
	
}

