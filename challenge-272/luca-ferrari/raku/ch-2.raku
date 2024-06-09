#!raku

#
# Perl Weekly Challenge 272
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-272>
#

sub MAIN( Str $string where { $string.elems > 0  } ) {
    my $score = 0;
    my @letters = $string.comb;

    for 0 ..^ @letters.elems - 1 -> $index {
	$score += abs( @letters[ $index ].Str.ord - @letters[ $index + 1 ].Str.ord );
    }

    $score.say;
}
