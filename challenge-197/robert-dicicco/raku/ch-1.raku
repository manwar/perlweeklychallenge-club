#!/usr/bin/env raku

#`{

AUTHOR: Robert DiCicco

DATE  : 2022-12-26

Challenge 197 Move Zero ( Raku )

}

 

use v6;

 

my @lists = ([1, 0, 3, 0, 0, 5],[1, 6, 4],[0, 1, 0, 2, 0]);

 

for (@lists) -> @list {

                my $i = 0;

                my @left = ();

                my @right = ();

                print("Input: \@list = \(" ~ @list ~ "\) \n");

                while $i < @list.elems {

                                if @list[$i] > 0 {

                                                @left.push: @list[$i];

                                } else {

                                                @right.push: @list[$i];

                                }

                               

                                $i++;

                }

                print("Output: (",@left," ",@right,")\n\n");

}

 

#`{

--------------------------------------------------------

SAMPLE OUTPUT

raku MoveZero.rk

Input: @list = (1 0 3 0 0 5)

Output: (1 3 5 0 0 0)

 

Input: @list = (1 6 4)

Output: (1 6 4 )

 

Input: @list = (0 1 0 2 0)

Output: (1 2 0 0 0)

}
