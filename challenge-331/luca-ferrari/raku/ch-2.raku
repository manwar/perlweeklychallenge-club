#!raku

#
# Perl Weekly Challenge 331
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-331>
#

sub MAIN( Str $left, Str $right ) {
    True.say and exit if ( $left.fc ~~ $right.fc );
    False.say and exit if ( $left.chars != $right.chars );

    my $permutations = +( [Z] $left.comb, $right.comb ).grep( { $_[ 0 ] ne $_[ 1 ] } );
    False.say and exit if ( $permutations > 2 );
    True.say;

}
