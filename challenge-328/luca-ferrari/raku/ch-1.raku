#!raku

#
# Perl Weekly Challenge 328
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-328>
#

sub MAIN( Str $string is copy where { $string ~~ / '?'+ / }  ) {
    $string.subst( / $<left>=(<[a .. z]>) <[?]> $<right>=(<[a .. z]>)? /,
							    { $<left> ~ ('a'..'z').grep( { $_ ne $<left> && $_ ne ( $<right> // '' ) } ).first ~ ( $<right> // '' ) },
							    :g )
    .say;

}
