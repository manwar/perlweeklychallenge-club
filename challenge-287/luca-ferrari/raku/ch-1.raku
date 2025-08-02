#!raku

#
# Perl Weekly Challenge 287
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-287>
#

sub MAIN( Str :$password ) {
# - It must have at least 6 characters.
# - It must contains at least one lowercase letter, at least one upper case letter and at least one digit.
    # - It shouldn't contain 3 repeating characters in a row.

    my $ok = True;
    'Too short'.say and $ok = False if ( $password.chars < 6 );
    'At least one lowercase char'.say and $ok = False if ( $password !~~ / <[a .. z]> / );
    'At least one uppercase char'.say and $ok = False if ( $password !~~ / <[A .. Z]> / );
    'At least one digit char'.say and $ok = False if ( $password !~~ / <[0 .. 9]> / );
    'No three repetitions in a row'.say and $ok = False if ( $password ~~ / (<[a..zA..Z0..9]>)$0$0  / );


    'Strong enough'.say if ( $ok );
    'Weak!'.say if ( ! $ok );
    exit( $ok ?? 0 !! 1 );
}
