#!raku

#
# Perl Weekly Challenge 369
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-369>
#

sub MAIN( Str $string is copy, Int $size, Str $filler
                                              where { $string.chars > 0 && $size > 0 && $filler.chars == 1 } ) {

    $string.say and exit if ( $size > $string.chars );

    while ( $string.chars !%% $size ) {
        $string ~= $filler;
    }

    my @parts = $string.comb.rotor( $size );
    @parts.join( ', ' ).say;

}
