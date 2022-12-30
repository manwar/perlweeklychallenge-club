#!/usr/bin/env perl

=begin

AUTHOR: Robert DiCicco

DATE  : 2022-12-26

Challenge 197 Move Zero ( Perl )

=cut

use strict;

use warnings;

use feature qw/say/;

 

my @lists = ([1, 0, 3, 0, 0, 5],[1, 6, 4],[0, 1, 0, 2, 0]);

 

for my $list (@lists) {

                my $i = 0;

                my @left = ();

                my @right = ();

                print("Input: \@list = \(@$list\) \n");

                while($i < scalar @$list){

                                if ($list->[$i] > 0){

                                                push(@left, $list->[$i]);

                                } else {

                                                push(@right, $list->[$i]);

                                }

                                $i++;

                }

                print("Output: ");

                say ("(@left @right)");

                print("\n");

}

=begin

--------------------------------------------------

SAMPLE OUTPUT

 

perl MoveZero.pl

Input: @list = (1 0 3 0 0 5)

Output: (1 3 5 0 0 0)

 

Input: @list = (1 6 4)

Output: (1 6 4 )

 

Input: @list = (0 1 0 2 0)

Output: (1 2 0 0 0)

=cut
