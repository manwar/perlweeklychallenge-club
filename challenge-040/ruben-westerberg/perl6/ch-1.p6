#!/usr/bin/env perl6

my @aoa=( <I L O V E Y O U>, <2 4 0 3 2 0 1 9>, <! ? £ $ % ^ & * >);
my @indexes=@*ARGS==0??(2,3)!!@*ARGS;
put $_ for @indexes.map({@aoa[*;$_].join: " "})
