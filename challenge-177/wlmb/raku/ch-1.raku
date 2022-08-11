#!/usr/bin/env raku
# Perl weekly challenge 177
# Task 1: Damm algorithm
#
# See https://wlmb.github.io/2022/08/08/PWC177/#task-1-damm-algorithm
die "Usage: $*PROGRAM-NAME N1 [N2... ]\nTo check Ni with Damm's algorithm\n" unless @*ARGS.Bool;
my @table=map {map {+$^x}, split(/\s*/,$^a,:skip-empty)},
	  <0317598642 7092154863 4206871359 1750983426 6123045978
	   3674209581 5869720134 8945362017 9438617205 2581436790>;
map {say "$^x ", (reduce {@table[$^a][$^b]}, unshift(split("", $^x, :skip-empty).Array,0))
		     ==0??"is"!!"isn't", " correct"},  @*ARGS;
