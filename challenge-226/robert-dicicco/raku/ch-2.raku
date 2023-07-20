#!/usr/bin/nev raku
use v6;
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-20
Challenge 226 Task 2 Zero Array ( Raku )
--------------------------------------
=end comment

my @ints = ([1, 5, 0, 3, 5],[0],[2, 1, 4, 0, 3]);
my $flag = 1;
my $cnt;

sub GetMinint(@x) {
    my $cnt = 0;
    my $minint = 100;
    while $cnt < @x.elems {
        if  @x[$cnt] > 0 and @x[$cnt] < $minint {
            $minint = @x[$cnt];
        }
        $cnt++;
    }
    return $minint;
}

my $cycle = 1;
for (@ints) -> @nts {
    while $flag == 1 {
        if ($cycle == 1) {
            say "Input: \@ints = ",@nts;
        }
        $cnt = 0;

        if @nts.elems == 1 and @nts[0] == 0 {
            last;
        }

        #### find min of array ( not including zero )
        my $minint = GetMinint(@nts);

        $cnt = 0;
        while $cnt < @nts.elems {
            if @nts[$cnt] > 0 {
                @nts[$cnt] -= $minint;
            }
            $cnt++;
        }

        say "operation $cycle: pick $minint ",@nts;
        $cycle++;

        $cnt = 0;
        $flag = 0;
        while  $cnt < @nts.elems  {
            if (@nts[$cnt] > 0) {
                $flag = 1;
            }
            $cnt++;
        }
     }
     print("Output: ",$cycle - 1,"\n");
     print("\n");
     $flag = 1;
     $cycle = 1;
}

=begin comment
--------------------------------------
SAMPLE OUTPUT
raku .\ZeroArray.rk

Input: @ints = [1 5 0 3 5]
operation 1: pick 1 [0 4 0 2 4]
operation 2: pick 2 [0 2 0 0 2]
operation 3: pick 2 [0 0 0 0 0]
Output: 3

Input: @ints = [0]
Output: 0

Input: @ints = [2 1 4 0 3]
operation 1: pick 1 [1 0 3 0 2]
operation 2: pick 1 [0 0 2 0 1]
operation 3: pick 1 [0 0 1 0 0]
operation 4: pick 1 [0 0 0 0 0]
Output: 4
--------------------------------------
=end comment


