#!raku

#
# Perl Weekly Challenge 211
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-211/>
#

sub MAIN() {

    my @matrix = [ [4, 3, 2, 1],
                   [5, 4, 3, 2],
                   [6, 5, 4, 3],
                 ];

    my %diag;
    %diag{ @matrix[ $_ ][ $_ ] }++ for 0 ..^ @matrix.elems;
    'False'.say if ( %diag.keys.elems != 1 || %diag{ @matrix[ 0 ][ 0 ] } != @matrix.elems );
    'True'.say;

}
