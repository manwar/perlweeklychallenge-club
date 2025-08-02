#!raku

#
# Perl Weekly Challenge 263
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
#

sub MAIN( Int $k, *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    @nums.sort.grep( * ~~ $k, :k ).say;

}
