#!raku

#
# Perl Weekly Challenge 254
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
#

sub MAIN( Str $word ) {
    my @reversed;
    my @vowels.push: |$word.lc.comb.grep( * ~~ / <[aeiou]> / ).reverse;

    for $word.comb {

	@reversed.push( $_ ) and next if ( $_.lc !~~ / <[aeiou]> / || @vowels.elems == 0 );
	@reversed.push: @vowels.shift if ( @vowels.elems > 0 );
    }

    @reversed.join.say;
}
