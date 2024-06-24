#!raku

#
# Perl Weekly Challenge 275
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-275>
#

sub MAIN( Str $sentence, *@keys ) {
    my @ok-words;

    for $sentence.lc.split( / \s+ / ) -> $word {
	my $ok = True;

	for @keys -> $needle {
	    $ok = False if ( $word ~~ / $needle / );
	    last if ! $ok;
	}

	@ok-words.push: $word if $ok;
    }

    @ok-words.elems.say;
}
