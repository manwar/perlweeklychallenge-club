#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/#TASK1
#
# Task 1: No Connection
# =====================
#
# You are given a list of routes, @routes.
#
# Write a script to find the destination with no further outgoing connection.
#
## Example 1
##
## Input: @routes = (["B","C"], ["D","B"], ["C","A"])
## Output: "A"
##
## "D" -> "B" -> "C" -> "A".
## "B" -> "C" -> "A".
## "C" -> "A".
## "A".
#
## Example 2
##
## Input: @routes = (["A","Z"])
## Output: "Z"
#
############################################################
##
## discussion
##
############################################################
#
# Look at all routes. Mark the beginning of the route as element with
# outgoing connections, and add the end of the route as an element
# without outgoing connections unless it already exists.
# In the end, all elements without any outgoing connections can be
# printed.

use strict;
use warnings;

no_connection(["B","C"], ["D","B"], ["C","A"]);
no_connection(["A","Z"]);

sub no_connection {
   my @routes = @_;
   print "Input: (" . join(", ", map { "[\"" . $_->[0] . "\", \"" . $_->[1] . "\"]"  } @routes) . ")\n";
   my $connections = {};
   foreach my $route (@routes) {
      $connections->{$route->[0]} = 1;
      $connections->{$route->[1]} ||= 0;
   }
   my @output = ();
   foreach my $connection (sort keys %$connections) {
      push @output, $connection unless $connections->{$connection};
   }
   print "Output: \"" . join("\", \"", @output) . "\"\n";
}
