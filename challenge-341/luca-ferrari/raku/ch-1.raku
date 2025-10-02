#!raku

#
# Perl Weekly Challenge 341
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-341>
#

sub MAIN( Str $text, *@keys ) {
    $text.say and exit( 0 ) unless ( @keys.elems );

    my @words;
    for $text.split( / \s+ / ) -> $current-word {
	my $found = 0;
	for @keys {
	    $found += $current-word.comb.grep( * ~~ $_ ).elems;
	}
	last if $found;

	@words.push: $current-word;
    }

    @words.join( ' ' ).say;
}
