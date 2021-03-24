#!/usr/bin/perl

# Challenge 105
#
# TASK #2 › The Name Game
# Submitted by: Mohammad S Anwar
# You are given a $name.
#
# Write a script to display the lyrics to the Shirley Ellis song The Name Game.
# Please checkout the wiki page for more information.
#
# Example
# Input: $name = "Katie"
# Output:
#
#     Katie, Katie, bo-batie,
#     Bonana-fanna fo-fatie
#     Fee fi mo-matie
#     Katie!

use strict;
use warnings;
use 5.030;

my $name = shift;
my $end = $name =~ s/^[bcdfghjklmnpqrstvwxyz]//ir;
my $b = ($name =~ /^b/i) ? "" : "b";
my $f = ($name =~ /^f/i) ? "" : "f";
my $m = ($name =~ /^m/i) ? "" : "m";

say "$name, $name, bo-$b$end,";
say "Bonana-fanna fo-$f$end";
say "Fee fi mo-$m$end";
say "$name!";
