#!/usr/bin/env raku
=begin comment
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-10
Challenge 225 Task 1 Max Words ( Raku )
-----------------------------------
=end comment
use v6;

my @lists = [["Perl and Raku belong to the same family.",
                "I love Perl.",
                "The Perl and Raku Conference."],
                ["The Weekly Challenge.",
                "Python is the most popular guest language.",
                "Team PWC has over 300 members."]];

my $max_num = 0;
my $num = 0;

for (@lists) -> $lst {
    say "Input: \@list = ($lst)";
    my $cnt = 0;
    while $cnt < $lst.elems {
        $num = $lst[$cnt].comb(/\w+/).elems;
        if $num > $max_num {
            $max_num = $num;
        }
        $cnt++;
    }
    say "Output: $max_num\n";
    $max_num = 0;
    $num = 0;
}

=begin comment
-----------------------------------
raku MaxWords.rk
Input: @list = (Perl and Raku belong to the same family. I love Perl. The Perl and Raku Conference.)
Output: 8

Input: @list = (The Weekly Challenge. Python is the most popular guest language. Team PWC has over 300 members.)
Output: 7
-----------------------------------
=end comment


