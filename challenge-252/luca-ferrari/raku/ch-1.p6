#!raku

#
# Perl Weekly Challenge 252
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    @nums.kv.map( { @nums.elems %% ( $^index + 1 ) ?? $^value ** 2 !! 0  } ).sum.say;
}
