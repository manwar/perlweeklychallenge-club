#/usr/bin/env raku

=begin comment

AUTHOR: Robert DiCicco

DATE  : 2023-01-30

Challenge 202 Consecutive Odds ( Raku )

=end comment



my @arrays = ([1,5,3,6],[2,6,3,5],[1,2,3,4],[2,3,5,7]);



for @arrays -> @arr {

    my $check = '';

    say "Input: \@array = ",@arr;

    loop (my $x = 0; $x < @arr.elems; $x++ ) {

        @arr[$x] % 2 == 0 ?? ($check ~= 'e') !! ($check ~= 'o');

    }

    $check.match(/ooo/) ?? say "Output: 1\n" !! say "Output: 0\n";

}



=begin comment

SAMPLE OUTPUT

raku .\ConsecutiveOdds.rk

Input: @array = [1 5 3 6]

Output: 1



Input: @array = [2 6 3 5]

Output: 0



Input: @array = [1 2 3 4]

Output: 0



Input: @array = [2 3 5 7]

Output: 1

=end comment
