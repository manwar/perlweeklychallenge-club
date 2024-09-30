#!raku

#
# Perl Weekly Challenge 289
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
#

sub MAIN( *@numbers is copy where { @numbers.grep( * ~~ Int ).elems == @numbers.elems } ) {
    @numbers = @numbers.sort.unique;
    @numbers.elems >= 3 ?? @numbers[ * - 3 ].say !! @numbers[ * - 1 ].say;
}
