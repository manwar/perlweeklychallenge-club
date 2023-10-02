#!/usr/bin/env raku
use v6;
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-08
Challenge 220 Task 2 Squareful ( Raku )
------------------------------------------
=end comment

my @ints = <1 8 17>,<1 8 17 19>;

sub IsPerfectSquare($number_to_test) {
    my $root = $number_to_test.sqrt.Int;
    if (($root ** 2 ) == $number_to_test) {
        return True;
    }
    return False;
}

for (@ints) -> @intsub {
    say "Input: \@ints = ",@intsub;
    print("Output: ");
    for (@intsub.permutations) -> @perm {
        my $tv = 0;
        my $flag = 0;
        while $tv < @intsub.elems - 1 {
            if (IsPerfectSquare(@perm[$tv] + @perm[$tv+1])) {
                $flag += 1;
            } else {
                $flag = 0;
            }
            $tv++;
        }
        if ($flag == (@intsub.elems - 1)) {
            print("(" ~ @perm ~ ") ");
        }
    }
    print("\n\n");
}



