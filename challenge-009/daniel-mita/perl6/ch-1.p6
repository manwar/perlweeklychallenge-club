#!/usr/bin/env perl6
use v6;

say first map ^∞: *²: *.comb.Set ≥ 5;
