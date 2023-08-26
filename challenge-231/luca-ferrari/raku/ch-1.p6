#!raku

#
# Perl Weekly Challenge 231
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-231/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my @wanted;
    @wanted.push: $_ if ( @nums.min < $_ < @nums.max ) for @nums;
    @wanted.join( ',' ).say;
}
