#!/usr/bin/env raku
#`{
-------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02-20
Challenge 205 Maximum XOR ( Raku )
-------------------------------
}

my $maxv = 0;
my @array = ([1,2,3,4,5,6,7], [2,4,1,3], [10,5,7,12,8]);

for (@array) -> @arr {
    say "Input: \@array = ",@arr;
    for @arr.combinations(2) {
        my $x = $_[0] +^ $_[1];
        if ($x > $maxv) {
            $maxv = $x;
        }
    }
    print("Output: $maxv\n");
    $maxv = 0;
    print("\n");
}

#`{
-------------------------------
SAMPLE OUTPUT
raku .\MaximumXOR.rk
Input: @array = [1 2 3 4 5 6 7]
Output: 7

Input: @array = [2 4 1 3]
Output: 7

Input: @array = [10 5 7 12 8]
Output: 15
}


