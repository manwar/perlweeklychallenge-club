#!raku

#
# Perl Weekly Challenge 230
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-230/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my @digits;
    @digits.push( | $_.comb ) for @nums;
    @digits.join( ', ' ).say;
}
