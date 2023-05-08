#!raku

#
# Perl Weekly Challenge 216
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-216/>
#

sub MAIN( *@strings is copy ) {
    my $letters = BagHash.new: @strings.pop.comb;
    my %stickers;
    my $loop = 0;

    while ( $letters.values.grep( * >= 1 ) ) {
	$loop++;

	for $letters.keys -> $needle {
	    next if ! $letters{ $needle };
	    my $found = False;
	    for @strings -> $word {
		if ( $word.comb.grep( $needle ) ) {
		    $letters{ $needle }--;
		    %stickers{ $word }{ $loop }.push: $needle;
		    $found = True;
		}
	    }

	    say "Cannot find $needle in any word!" and exit if ! $found;
	}
    }

    "$_ used { %stickers{ $_ }.keys.elems } times".say for %stickers.keys;
}
