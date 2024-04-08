#!raku

#
# Perl Weekly Challenge 264
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
#

sub MAIN( Str $string where { $string ~~ / ^ <[a..zA..Z]>+ $ / } ) {
    my @letters;

    for $string.comb.grep( * ~~ / <[A..Z]> / ) -> $letter {
	next if ! $string ~~ / $letter.lc /;
	@letters.push: $letter;
    }

    @letters.sort[ * - 1 ].say if ( @letters );
}
