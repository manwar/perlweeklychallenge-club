#!/usr/bin/env raku
=begin comment
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-16
Challenge 239 Task 01 Same String ( Raku )
------------------------------------
=end comment

my @myarr1 = (["ab", "c"],["ab", "c"],["ab", "cd", "e"]);
my @myarr2 = (["a", "bc"],["ac", "b"],["abcde"]);

my $cnt = 0;

while $cnt < @myarr1.elems {
    say "Input:  \@arr1 = [@myarr1[$cnt]]";
    say "\t\@arr2 = [@myarr2[$cnt]]";
    @myarr1[$cnt].join eq @myarr2[$cnt].join ?? say "Output: true\n" !! say "Output: false\n";
    $cnt++;
}

=begin comment
-------------------------------------
SAMPLE OUTPUT

raku .\SameString.rk

Input:  @arr1 = [ab c]
        @arr2 = [a bc]
Output: true

Input:  @arr1 = [ab c]
        @arr2 = [ac b]
Output: false

Input:  @arr1 = [ab cd e]
        @arr2 = [abcde]
Output: true
------------------------------------
=end comment


