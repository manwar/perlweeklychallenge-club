#!/usr/bin/env -S perl -C63

=pod

The Weekly Challenge #285-1: "No Connection"
Submitted by: Mohammad Sajid Anwar
You are given a list of routes, @routes. Write a script to find
the destination with no further outgoing connection.

Example 1:
Input: @routes = (["B","C"], ["D","B"], ["C","A"])
Output: "A"
"D" -> "B" -> "C" -> "A".
"B" -> "C" -> "A".
"C" -> "A".
"A".

Example 2:
Input: @routes = (["A","Z"])
Output: "Z"

Solution in Perl written by Robbie Hatley on Fri Sep 06, 2024.

Input is by @ARGV or internal array. If using @ARGV, provide one input which must be a single-quoted array of
arrays of arrays of route nodes, in proper Perl syntax, like so:
./ch-1.pl '([["A","B","C"],["B","A","C"],["C","B"]],[["A","E","X"],["X","E","F"],["A","B","C","A"]])'

Output is to STDOUT and will be each input followed by its corresponding output.

=cut

use v5.36;
use utf8;
$"=', ';

sub deadends ($route_set_ref) {
   my %live;
   my %dead;
   my @routes = @$route_set_ref;
   for my $route (@routes) {
      my @nodes = @$route;
      for my $i (0..$#nodes) {
         if ($i < $#nodes) {
            if (not defined $live{$nodes[$i]}) {
               $live{$nodes[$i]} = 1;
            }
         }
      }
   }
   for my $route (@routes) {
      if (not defined $live{$route->[-1]}) {
         if (not defined $dead{$route->[-1]}) {
            $dead{$route->[-1]} = 1;
         }
      }
   }
   return sort keys %dead;
}

my @route_sets = @ARGV ? eval($ARGV[0]) :
(
   [["B","C"], ["D","B"], ["C","A"]],
   [["A","Z"]],
);

for my $route_set_ref (@route_sets) {
   my @deadends = deadends($route_set_ref);
   say '';
   say 'Routes:';
   say "@$_" for @$route_set_ref;
   say "Deadends = @deadends";
}



