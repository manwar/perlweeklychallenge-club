#!/usr/bin/env perl
=begin comment
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-16
Challenge 239 Task 01 Same String ( Perl )
------------------------------------
=cut
use v5.38;

my @myarr1 = (["ab", "c"],["ab", "c"],["ab", "cd", "e"]);
my @myarr2 = (["a", "bc"],["ac", "b"],["abcde"]);
my ($arr1, $arr2,$arr1_val,$arr2_val);

my $cnt = 0;
while ( $cnt < scalar @myarr1) {
    say "Input:  \@arr1 = [@{$myarr1[$cnt]}]";
    say "\t\@arr2 = [@{$myarr2[$cnt]}]";
    join("",@{$myarr1[$cnt]}) eq join("",@{$myarr2[$cnt]}) ? say "Output: true\n" : say "Output: false\n" ;
    $cnt++;
}

=begin comment
-------------------------------------
SAMPLE OUTPUT

perl .\SameString.pl

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
=cut



