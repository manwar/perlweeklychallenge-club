#!/usr/bin/env raku
=begin comment
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Count Words Task 2 ( Raku )
----------------------------------
=end comment
use v6;

my @wds = (["pay", "attention", "practice", "attend"],["janet", "julia", "java", "javascript"]);
my @prefix = ("at", "ja");

my $cnt = 0;
#my $seen = 0;
for (@wds) -> @w {
my $seen = 0;
    say "Input:  \@words = ",[@w];
    my $p = @prefix[$cnt];
    say "\t\$prefix = \"$p\"";
    for (@w) -> $elem {
        if $elem ~~ /^$p/ {
            $seen++;
        }
    }
    say "Output: $seen\n";
    $cnt++;
}

=begin comment
----------------------------------
SAMPLE OUTPUT
raku .\CountWords.rk

Input:  @words = [pay attention practice attend]
        $prefix = "at"
Output: 2

Input:  @words = [janet julia java javascript]
        $prefix = "ja"
Output: 3
----------------------------------
=end comment


