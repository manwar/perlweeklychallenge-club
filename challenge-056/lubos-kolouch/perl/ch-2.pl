#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/
#
#               Task 2
#
#               You are given a binary tree and a sum, write a script to find if the tree has a path such that adding up all the values along the path equals the given sum. Only complete paths (from root to leaf node) may be considered for a sum.
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 04/18/2020 02:22:24 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Graph::Directed;
use List::Util qw/sum/;
use feature qw/say/;

my $g = Graph::Directed->new;

$g->add_edge(5,4);
$g->add_edge(4,11);
$g->add_edge(11,7);
$g->add_edge(11,2);
$g->add_edge(5,8);
$g->add_edge(8,13);
$g->add_edge(8,9);
$g->add_edge(9,1);

my $start = 5;
my $sum = 22;

for ($g->exterior_vertices) {
    my @path = $g->SP_Dijkstra($start, $_);

    say join '->', @path if sum(@path) == $sum;
}
