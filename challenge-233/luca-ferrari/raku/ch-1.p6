#!raku

#
# Perl Weekly Challenge 233
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-233/>
#

sub MAIN( *@words where { @words.elems > 1  } ) {
    my %similars;
    for @words -> $word {
	my $key = $word.comb.sort.join;
	%similars{ $key }.push: $word;
    }

    say 'Similar words: ' ~ $_.join( ' <-> ' ) for %similars.values.grep( *.elems > 1 );
}
