#!/usr/bin/env perl

=begin comment

AUTHOR: Robert DiCicco

DATE:   2023-01-23

Challenge 201 Missing Numbers ( Perl )

=cut

use strict;

use warnings;

use feature qw/say/;



my @arrs = ([0,1,3],[0,1]);





for my $arr (@arrs) {

    my $len = @$arr;

    print("Input: \@array = \[@$arr\]\n");

    for (my $x = 0; $x <= $len; $x++ ){

        if ( grep( /$x/, @$arr ) ) {

            next;

        } else {

            print "Output: $x\n\n";

        }

    }

}



=begin comment

SAMPLE OUTPUT

perl .\MissingNumbers.pl

Input: @array = [0 1 3]

Output: 2



Input: @array = [0 1]

Output: 2

=cut
