#!raku

#
# Perl Weekly Challenge 239
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
#

sub MAIN( Str $allowed, *@words ) {
    my @allowed;
    for @words -> $current-word {
	my $found = True;

	for $current-word.comb -> $current-char {
	    $found = False and last if ( ! $allowed.comb.grep( * ~~ $current-char ) );
	}

	@allowed.push: $current-word if ( $found );
    }

    @allowed.join( ', ' ).say;
}
