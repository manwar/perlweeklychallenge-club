#!raku

#
# Perl Weekly Challenge 258
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    @nums.map( { $_.comb.elems %% 2 ?? 1 !! 0 } ).sum.say;

}
