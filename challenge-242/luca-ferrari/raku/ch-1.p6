#!raku

#
# Perl Weekly Challenge 242
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-242/>
#

sub MAIN( Str $left, Str $right ) {

    my @left = $left.split( ',' ).map( *.Int );
    my @right = $right.split( ',' ).map( *.Int );

    my ( @missing-left, @missing-right );

    @missing-left.push: $_ if ( ! @left.grep( $_ ) )  for @right;
    @missing-right.push: $_ if ( ! @right.grep( $_ ) )  for @left;

    ( @missing-left, @missing-right ).say;
}
