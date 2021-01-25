#!/usr/bin/env perl6
use v6;

# run <script> <binary string> <integer>

sub res(@strs) { zip(@strs).map(-> @s {@s.classify({$_}).max(*.value.elems).value.head}) }

sub toflip(@target,@strs) { @strs.map(-> @s {(@s Z!== @target).grep({$_}).elems}).sum }

my @strs = @*ARGS[0].comb.rotor(@*ARGS[1].Int);
my @target = res(@strs.List);

say qq|Flip a total number of {toflip(@target,@strs)} positions to get {@target.join} from\n{@strs.map(*.join).join("\n")}|
