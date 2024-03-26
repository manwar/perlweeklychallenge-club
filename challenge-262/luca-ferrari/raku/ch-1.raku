#!raku

#
# Perl Weekly Challenge 262
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-262>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    ( @nums.grep( * >= 0 ).elems, @nums.grep( * < 0 ).elems ).max.say;

}
