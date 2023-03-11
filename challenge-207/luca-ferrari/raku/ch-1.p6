#!raku

#
# Perl Weekly Challenge 207
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-207/>
#

sub MAIN( *@words ) {
    my @keyboard = qw/ qwertyuiop asdfghjkl zxcvbnm /;

    for @words -> $current-word {
	for @keyboard -> $current-row {
	    my $found = 0;
	    for $current-word.lc.comb -> $current-letter {
		$found++ if ( $current-row ~~ /$current-letter/  );
	    }

	    $current-word.say if $current-word.chars == $found;
	}
    }

}
