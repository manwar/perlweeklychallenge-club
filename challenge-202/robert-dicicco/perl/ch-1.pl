#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE  : 2023-01-30

Challenge 202 Consecutive Odds

=cut

use strict;

use warnings;

use feature qw/say/;



my @arrays = ([1,5,3,6],[2,6,3,5],[1,2,3,4],[2,3,5,7]);



for my $arr (@arrays) {

    my $check = '';

    say "Input: \@array = [@$arr]";

    for (my $x = 0; $x < @$arr; $x++ ) {

        $arr->[$x] % 2 == 0 ? $check .= 'e' : $check .= 'o';

    }

    $check =~ m/ooo/ ? say "Output : 1\n" : say "Output : 0\n";

}



=begin pod

SAMPLE OUTPUT

perl .\ConsecutiveOdds.pl

Input: @array = [1 5 3 6]

Output : 1



Input: @array = [2 6 3 5]

Output : 1



Input: @array = [1 2 3 4]

Output : 0



Input: @array = [2 3 5 7]

Output : 1

=cut
