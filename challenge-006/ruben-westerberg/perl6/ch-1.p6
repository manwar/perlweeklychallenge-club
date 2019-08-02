#!/usr/bin/env perl6
my $string= @*ARGS ?? @*ARGS.join(",")!! prompt "Enter numbers: ";
my $a=$string.split(",",:skip-empty)>>.trim.grep({!/^$/})>>.Int.Bag;
my @r1=$a.keys.sort;
my @diff=@r1.rotate >>-<< @r1;
my @p=(0,|map {|($^k,$k+1) if abs($^v) > 1}, @diff.kv);

@p.pop;
say join ",", map {@r1[$^a]==@r1[$^b]??@r1[$^a]!!"@r1[$^a]-@r1[$^b]"}, @p;


