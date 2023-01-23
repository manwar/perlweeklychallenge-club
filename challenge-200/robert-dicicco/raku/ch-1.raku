#/usr/bin/env raku

=begin comment

AUTHOR: Robert DiCicco

DATE:   01-18-2023

Challenge #200 Arithmetic Slices ( Raku )

=end comment

use v6;

 

my @out = ();

my @lists = ([1,2,3,4],[2]);

 

sub GetIntervals(@slice) {

                return -1 if (@slice.elems < 3);

                my $x = 0;

                               

                while ( $x < @slice.elems ) {

                                if ( $x > 0 ) {

                                                my $interval = @slice[$x] - @slice[$x-1];

                                                @out.push: $interval;

                                }

                                $x++;

                }

                my $testval = @out[0];

                for (@out) -> $arrint {

                                if ( $arrint != $testval ) {

                                                return -1;

                                }

                }

                return 1;

}

 

for (@lists) -> @list  {

                my $cnt = 0;

                print("Input: \@array = \[",@list,"\]\n");

                my @slice;

                print("Output: ");

                while $cnt < @list.elems - 2 {

                                @slice = @list[$cnt..$cnt+2];

                                if @slice.elems == 3 {

                                                my $retval = GetIntervals(@slice);

                                                if $retval == 1 {

                                                                print("[",@slice,"] ");

                                                }

                                }

                                $cnt++;

                                @slice = ();

                }

                my $ret = GetIntervals(@list);

                $ret == 1 ?? print("[",@list,"]\n") !! print("()\n");

                print("\n");

}

 

 

=begin comment

SAMPLE OUTPUT

raku .\ArithmeticSlices.rk

Input: @array = [1 2 3 4]

Output: [1 2 3] [2 3 4] [1 2 3 4]

 

Input: @array = [2]

Output: ()

=end comment
