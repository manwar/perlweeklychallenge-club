#!/usr/bin/env perl6
#
#
#       missing-in-sequence.raku
#
#         Missing Row
#         Submitted by: Mohammad S Anwar
#         You are given text file with rows numbered 1-15 in random order but
#         there is a catch one row in missing in the file.
# 
#         11, Line Eleven
#         1, Line one
#         9, Line Nine
#         13, Line Thirteen
#         2, Line two
#         6, Line Six
#         8, Line Eight
#         10, Line Ten
#         7, Line Seven
#         4, Line Four
#         14, Line Fourteen
#         3, Line three
#         15, Line Fifteen
#         5, Line Five
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $file = './missing.txt' ) ;

my %set = $file.IO
    .lines
    .map( *.comb: /\d+/, 1 )
    .Set;
    
my @missing =  (1..%set.keys.max({$_.Int})).grep: { $_.Str ∉ %set } ;

if @missing.elems -> $count {
    say $count, ($count == 1
        ?? " line is "
        !! " lines are "), "missing:";
    "line $_".say for @missing;
}
else {
    say "all lines accounted for!";
}




