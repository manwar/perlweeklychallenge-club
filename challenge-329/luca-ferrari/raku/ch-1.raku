#!raku

#
# Perl Weekly Challenge 329
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-329>
#

sub MAIN( Str $string where { $string ~~ / <[a..zA..Z0..9]>+ / } ) {
    my %digits;
    for ( $string ~~ m:g/ <[0..9]>+ / ).values {
	%digits{ $_ }++;
    }

    %digits.keys.sort.join( ',' ).say;
}
