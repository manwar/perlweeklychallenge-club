#!/usr/bin/env perl6
use v6;

# run as <script> <size> or just <script> to default to size 2

use Cache::LRU;

my $size=(@*ARGS) ?? (@*ARGS[0].Int) !! (2);
my $cache = Cache::LRU.new(size => $size);

(1..$size).map({ $cache.set($_, ('a'..'z').roll(3).join); say "key: $_,   value: {$cache.get($_)}" });

say "\nSetting new item at key {$size+1}..";
$cache.set($size+1, ('a'..'z').roll(3).join);
say "\nNew cache:";
(1..$size+1).map({ (my $val=$cache.get($_)) && say "key: $_,   value: {$val}" });
