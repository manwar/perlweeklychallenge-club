#!/usr/bin/env raku

unit sub MAIN(*@nums);

@nums = @nums>>.Int.sort;
die "No even number!" unless @nums.grep(* %% 2);

my Int $least-even = @nums.splice(@nums.first(* %% 2, :k), 1).first;
say (|@nums.reverse, $least-even).join;
