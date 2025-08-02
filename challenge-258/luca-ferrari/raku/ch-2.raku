#!raku

#
# Perl Weekly Challenge 258
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
#

sub MAIN( Int $k where { $k > 0 } , *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my @indexes = ( 0 ..^ @nums.elems ).grep( { $_.base( 2 ).comb.grep( * == 1 ).elems == $k } );
    @nums[ @indexes ].sum.say;

}
