#!/usr/bin/env raku
=begin comment
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Senior Citizen Task 2 ( Raku )
----------------------------------------
=end comment

use v6;

my @lists = (["7868190130M7522","5303914400F9211","9273338290F4010"],["1313579440F2036","2921522980M5644"]);
my $cnt;

for (@lists) -> @list {
    $cnt = 0;
    say "Input: \@list = ",@list;
    for (@list) -> $info {
        my $age = substr($info,11,2);
        if ($age >= 60) {
            $cnt++;
        }
    }
    say "Output: $cnt\n";
}

=begin comment
----------------------------------------
SAMPLE OUTPUT
raku .\SeniorCit.rk

Input: @list = [7868190130M7522 5303914400F9211 9273338290F4010]
Output: 2

Input: @list = [1313579440F2036 2921522980M5644]
Output: 0
----------------------------------------
=end comment


