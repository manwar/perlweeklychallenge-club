#!raku

#
# Perl Weekly Challenge 265
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
#

sub MAIN( Str $needle, *@strings ) {

    my %letters;
    %letters{ $_.lc }++ if ( $_ !~~ / <[0..9]> | \s / ) for $needle.comb;

    my %completing-words;

    for @strings -> $current {
	my $ok = True;
	for %letters.kv -> $letter, $count {
	    $ok = False and last if $current.comb.grep( $letter ).elems < $count;
	}
	%completing-words{ $current.chars } = $current if $ok;
    }

    %completing-words{ %completing-words.keys.min }.say;
}
