#!/usr/bin/env perl6
#
#
#       the-path-in-the-pyramid.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

my @triangle = [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8];

my @out = @triangle.map( { $_.min });

say "minimum sum path: {@out.join(' + ')} => {@out.sum}";



