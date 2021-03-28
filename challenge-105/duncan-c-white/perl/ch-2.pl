#!/usr/bin/perl
# 
# Task 2: "The Name Game
# 
# You are given a $name.
# 
# Write a script to display the lyrics to the Shirley Ellis song The Name
# Game. Please checkout https://en.wikipedia.org/wiki/The_Name_Game
# for more information.
# 
# Example
# 
#   Input: $name = "Katie"
#   Output:
# 
#     Katie, Katie, bo-batie,
#     Bonana-fanna fo-fatie
#     Fee fi mo-matie
#     Katie!
# "
# 
# My notes: wtf?  are we reduced to ill-defined childhood rhymes now?
# use simple rules:
# - remove first consonant from name if the first letter is a consonant,
# - otherwise leave the name alone.
# - if the removed consonant was b, f or m, then (respectively) bo-b
#   becomes bo-, fo-f becomes fo-, and mo-m becomes mo-
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: the-name-game [--debug] name\n"
	unless GetOptions( "debug" => \$debug ) && @ARGV==1;

my $name = shift;

my $y = lc($name);
$y =~ s/^([bcdfghjklmnpqrstvwxyz])//;
my $deleted = $1 // '';

my $by = $deleted eq 'b' ? $y : "b$y";
say "$name $name bo-$by";
my $fy = $deleted eq 'f' ? $y : "f$y";
say "Bonana-fanna fo-$fy";
my $my = $deleted eq 'm' ? $y : "m$y";
say "Fee fi mo-$my";
say "$name";
