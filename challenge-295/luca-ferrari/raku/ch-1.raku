#!raku

#
# Perl Weekly Challenge 295
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-295>
#

sub MAIN( Str $string is copy, *@words ) {
    for @words -> $current-word {
    last if ( $string !~~ /$current-word/ );
    $string .= subst( $current-word, '', :g );
    }

    'True'.say if ! $string;
    'False'.say if $string;
}
