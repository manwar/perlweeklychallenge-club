#!/usr/bin/env raku
#`{
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-04
Challenge 211 Split Same Average ( Raku )
----------------------------------------
}

my @nums = (1,2,3,4,5,6,7,8);

my $flag = 0;

say "Input: \@nums = ",@nums;
for @nums.combinations(4) -> @pn {
    my $first = ([+] @pn) / @pn.elems ;
    my @sec = @nums.grep(none @pn);
    my $second = ([+] @sec) / @sec.elems ;
    if $first == $second { $flag = 1};
    say "-----> ("~@pn~') ('~@sec~') '~"  $first : $second"  if $first == $second;
}

$flag == 1 ?? (say "Output: true") !! (say "Output: false");

#`{
----------------------------------------
SAMPLE OUTPUT
raku .\SplitSame.rk
Input: @nums = [1 2 3 4 5 6 7 8]
-----> (1 2 7 8) (3 4 5 6)   4.5 : 4.5
-----> (1 3 6 8) (2 4 5 7)   4.5 : 4.5
-----> (1 4 5 8) (2 3 6 7)   4.5 : 4.5
-----> (1 4 6 7) (2 3 5 8)   4.5 : 4.5
-----> (2 3 5 8) (1 4 6 7)   4.5 : 4.5
-----> (2 3 6 7) (1 4 5 8)   4.5 : 4.5
-----> (2 4 5 7) (1 3 6 8)   4.5 : 4.5
-----> (3 4 5 6) (1 2 7 8)   4.5 : 4.5
Output: true
}


