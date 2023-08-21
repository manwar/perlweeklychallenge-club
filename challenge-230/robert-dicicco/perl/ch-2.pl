#!/usr/bin/env perl
=begin comment
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Count Words Task 2 ( Perl )
----------------------------------
=cut
use v5.38;

my @wds = (["pay", "attention", "practice", "attend"],["janet", "julia", "java", "javascript"]);
my @prefix = ("at", "ja");

my $cnt = 0;
my $seen = 0;
for my $w (@wds) {
    say "Input:  \@words = [@$w]";
    say "\t\$prefix = \"$prefix[$cnt]\"";
    for my $elem (@$w) {
        if ($elem =~ m/^$prefix[$cnt]/) {
            $seen++;
        }
    }
    say "Output: $seen\n";
    $seen = 0;
    $cnt++;
}
=begin comment
----------------------------------
SAMPLE OUTPUT
perl .\CountWords.pl

Input:  @words = [pay attention practice attend]
        $prefix = "at"
Output: 2

Input:  @words = [janet julia java javascript]
        $prefix = "ja"
Output: 3
----------------------------------
=cut


