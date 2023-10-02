#!raku

#
# Perl Weekly Challenge 234
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-234/>
#

sub MAIN( *@words ) {
    my %chars;
    for @words -> $current_word {
	for $current_word.comb.unique.sort {
	    %chars{ $_ }.push: $current_word;
	}
    }

    for %chars.kv -> $char, $list {
	say $char if $list.elems == @words.elems;
    }

}
