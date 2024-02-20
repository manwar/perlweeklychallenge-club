#!raku

#
# Perl Weekly Challenge 256
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
#

sub MAIN( *@words ) {
    my %counting;
    for @words -> $current-word {
	%counting{ $current-word } = @words.grep( { $_ ~~ $current-word.flip } ).elems;
    }

    %counting.values.max.say;
}
