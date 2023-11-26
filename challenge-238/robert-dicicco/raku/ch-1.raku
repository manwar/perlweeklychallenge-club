#!/usr/bin/env raku

=begin comment
---------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-09
Challenge 238 Task 01 Running Sum ( Raku )
---------------------------------
=end comment

my @myints = ([1, 2, 3, 4, 5],[1, 1, 1, 1, 1],[0, -1, 1, 2]);

for (@myints) -> @mints {
    my $sum = 0;
    my @out = ();
    say "Input: \@int = ", @mints;
    for (@mints) -> $i {
        @out.push($i + $sum);
        $sum += $i;
    }
    say "Output: ",@out,"\n";
}

=begin comment
---------------------------------
SAMPLE OUTPUT
raku .\RunningSum.rk

Input: @int = [1 2 3 4 5]
Output: [1 3 6 10 15]

Input: @int = [1 1 1 1 1]
Output: [1 2 3 4 5]

Input: @int = [0 -1 1 2]
Output: [0 -1 0 2]
---------------------------------
=end comment


