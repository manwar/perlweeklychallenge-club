#!raku

#
# Perl Weekly Challenge 271
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-271>
#

sub MAIN() {

    my $matrix = [ [0, 0],
                   [1, 1],
                   [0, 0],
                 ];

    my $row = 1;
    $matrix.map( { [ $row++, $_.grep( * ~~ 1 ).elems  ] } ).grep( { $_[ 1 ] > 0 } ).map( { $_[0] } ).min.say;
}
