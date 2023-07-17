#!raku

#
# Perl Weekly Challenge 226
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-226/>
#

sub MAIN( Str $string, *@indexes
			 where { @indexes.grep( * ~~ Int ).elems == @indexes.elems && @indexes.elems == $string.chars }
	) {
    my $index = 0;
    my %letters;
    %letters{ @indexes[ $index++ ] } = $_  for $string.comb;

    %letters{ @indexes.sort }.join.say;

}
