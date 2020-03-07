#!/usr/bin/env perl6

my @L = [2, 6, 1, 3];

@L                                    ==>
grep  { $_ < @L.elems }               ==> # skip numbers that aren't possible
first { @L.grep(* > $_).elems == $_ } ==> # I'm trusting there can only be 1 
say();
