#!/usr/bin/perl

use File::Slurper qw/ read_lines /;

my @states = read_lines('state-codes.txt');
my $re     = join('|', @states);
my @words  = grep { /^($re)+$/ }
             sort { length($b) <=> length($a) }
             read_lines('word-list.txt');

print $words[0], "\n";
