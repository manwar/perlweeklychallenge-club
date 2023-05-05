#!/usr/bin/env raku
#`{
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-02
Challenge 215 Number Placement ( Raku ) CORRECTED VERSION

When entering, the first digit is the count, the remainder is the array
For example, the first example would be 1 1 0 0 0 1
which stands for a count of one, with array 1 0 0 0 1
-----------------------------------------
}
use v6;

sub CheckZeroes(@arr is copy) {
    my $zcnt = 0;
    #say "zcnt = $zcnt";
    while $zcnt < @arr.elems - 1 {
        if ((@arr[$zcnt] == 0) && (@arr[$zcnt-1] == 0)) {
             @arr[$zcnt] = 1;
        }
        $zcnt++;
    }
    say "Output: 1 = ",@arr;
}

sub HowManyZeroes(@arr) {
    my $z = 0;
    my $zcnt = 0;
    while $z < (@arr.elems) - 1 {
        if (@arr[$z] == 0) {
            $zcnt++;
        }
        $z++;
    }
    return $zcnt;
}

unit sub MAIN ($count where 0 <= $count <= 9, *@numbers where @numbers.elems > 0 && all(@numbers) ~~ UInt);
say "Input: \@numbers = ", @numbers;
say "Count = $count";

#my $test = HowManyZeroes(@numbers);

my $zeroes = HowManyZeroes(@numbers);

if ($zeroes < $count * 2) {
    say "Output: 0";
} else {
    CheckZeroes(@numbers);
}


#`{
-----------------------------------------
SAMPLE OUTPUT
raku .\NumberPlacement.rk 1 1 0 0 0 1
Input: @numbers = [1 0 0 0 1]
Count = 1
Output: 1 = [1 0 1 0 1]

PS G:\Projects\Perl\Challenges> raku .\NumberPlacement.rk 2 1 0 0 0 1
Input: @numbers = [1 0 0 0 1]
Count = 2
Output: 0

PS G:\Projects\Perl\Challenges> raku .\NumberPlacement.rk 3 1 0 1 0 0 0 0 0 1
Input: @numbers = [1 0 0 0 0 0 0 0 1]
Count = 3
Output: 1 = [1 0 1 0 1 0 1 0 1]
-----------------------------------------
}
