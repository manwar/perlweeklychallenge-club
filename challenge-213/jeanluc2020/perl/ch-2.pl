#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-213/#TASK2
#
# Task 2: Shortest Route
# ======================
#
# You are given a list of bidirectional routes defining a network of nodes, as well as source and destination node numbers.
#
# Write a script to find the route from source to destination that passes through fewest nodes.
#
## Example 1:
##
## Input: @routes = ([1,2,6], [5,6,7])
##        $source = 1
##        $destination = 7
##
## Output: (1,2,6,7)
##
## Source (1) is part of route [1,2,6] so the journey looks like 1 -> 2 -> 6
## then jump to route [5,6,7] and takes the route 6 -> 7.
## So the final route is (1,2,6,7)
#
## Example 2:
##
## Input: @routes = ([1,2,3], [4,5,6])
##        $source = 2
##        $destination = 5
##
## Output: -1
#
## Example 3:
##
## Input: @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8])
##        $source = 1
##        $destination = 7
## Output: (1,2,3,8,7)
##
## Source (1) is part of route [1,2,3] so the journey looks like 1 -> 2 -> 3
## then jump to route [3,8,9] and takes the route 3 -> 8
## then jump to route [7,8] and takes the route 8 -> 7
## So the final route is (1,2,3,8,7)
#
############################################################
##
## discussion
##
############################################################
#
# We first search for a potential source, from which we look
# for all possible paths, from which we select shortest one
# We do this by creating all possible permutations of the
# list of paths, then try to walk each of those as follows:
# - find the source in the first path
# - for each possible middle destination in this path, walk
#   to that point, then jump to the next path, searching this
#   middle destination as the new source, and walk from the
#   next path in the same manner.
# - if at some point during this walk we find the final
#   destination, then we have found the shortest path with
#   the current permutation of the original array and keep
#   the found solution, backtracking again to the next
#   permutation
# - in the end pick the first solution with the minimum
#   amount of steps (this only makes a difference if there
#   are indeed multiple paths of the same "length".

use strict;
use warnings;

shortest_route(1, 7, [1,2,6], [5,6,7]);
shortest_route(2, 5, [1,2,3], [4,5,6]);
shortest_route(1, 7, [1,2,3], [4,5,6], [3,8,9], [7,8]);
shortest_route(1, 7, [1,2,3], [4,5,6], [3,8,9], [7,8]);
shortest_route(1, 7, [1,2,3], [4,5,6], [3,8,9], [7,8], [3,5,7]);
shortest_route(1, 7, [1,2,3], [4,5,6], [3,8,9], [3,5,7]);
shortest_route(1, 7, [1,2,3], [4,5,6], [3,8,9], [3,5,6,7], [2,7]);
shortest_route(1, 7, [1,2,3,4,5,6,7], [2,7]);

# This is the "outer" function. It prints the input, calls a
# function to create all permutations of the input array @routes,
# then collects the potential solutions for each of these
# permutations. If nothing was found, the output "-1" is printed.
# Otherwise, the first path with the least amount of steps is
# selected and printed.
sub shortest_route {
   my ($source, $destination, @routes) = @_;
   # print the input
   print "Input: \@routes = ( ";
   my $first = 1;
   foreach my $elem (@routes) {
      print ", " unless $first;
      $first = 0;
      print "[" . join(",", @$elem) . "]";
   }
   print " )\n\$source = $source\n\$destination = $destination\n";
   # find all possible permutations of the input array @routes
   my @permutations = get_permutations(@routes);
   my @found_routes = ();
   # collect the solutions for each permutation
   foreach my $p (@permutations) {
      push @found_routes, find_more_routes($source, $destination, @$p);
   }
   # if no solution was found we're done
   unless(@found_routes) {
      print "Output: -1\n";
      return;
   }
   # find shortest route
   my $min = $found_routes[0]->[0];
   my $min_route = $found_routes[0]->[1];
   foreach my $elem (@found_routes) {
      if($elem->[0] < $min) {
         $min = $elem->[0];
         $min_route = $elem->[1];
      }
   }
   # print the result
   print "Output: $min (" . join(",", @$min_route) . ")\n";
}

# given a permutation of the routes, this function will pick the
# source in the first route, then walk to each possible destination
# inside this route and use that as an intermediate source to start
# from in the next route (which is then a recursive call to the same
# function with the start_route eliminated)
sub find_more_routes {
   my ($source, $destination, $start_route, @remaining_routes) = @_;
   # if there is no start_route we hit the end of recursion since
   # we're out of routes
   return () unless $start_route;
   my @start_route = @$start_route;
   my @results = ();
   my $start_position = -1;
   # find where in the start route the source is
   foreach my $i (0..$#start_route) {
      if($start_route[$i] == $source) {
         $start_position = $i;
         last;
      }
   }
   # return an empty result set if the source was not found
   # since all possible solutions will be found by other
   # permutations, not this one
   return () if $start_position == -1;
   # check if the destination is also in the start route
   my $end_position = -1;
   foreach my $i (0..$#start_route) {
      if($start_route[$i] == $destination) {
         $end_position = $i;
         last;
      }
   }
   # if we found the destination in the start route we can add
   # the corresponding path to the solution set. This can be
   # forward or backward, so check both cases
   # It is important that this might not be the shortest path
   # overall. If we have source 1, destination 7 and the routes
   # [1,2,3,4,5,6,7], [2,7], then (1,2,3,4,5,6,7) is not the
   # shortest path even though it is in the same single route.
   # So we just keep the solution, but we keep searching for
   # other solutions recursively below as well
   if($end_position != -1) {
      if($end_position > $start_position) {
         my $len = $end_position - $start_position;
         my @path = @start_route[$start_position..$end_position];
         push @results, [$len, [@path]];
      } else {
         my $len = $start_position - $end_position;
         my @path = reverse @start_route[$end_position..$start_position];
         push @results, [$len, [@path]];
      }
   }

   # starting from the source in the start route, go forward and backward
   # to any element in the list, search for all paths with this new source
   # and the remaining routes and add those results to the temporary length and path
   # that were found so far. push all found results onto the @results array
   # We start with the first half of the start_route (destinations that are
   # before the source in the start_route)
   foreach my $i (0..$start_position-1) {
      my $len = $start_position - $i;
      my @path = reverse @start_route[$i..$start_position]; # path (1,2,3) turns into (3,2,1)
      last if $i == $end_position; # if we happen to find our final destination we are done
      my $new_start = $start_route[$i];
      my @tmp_results = find_more_routes($new_start, $destination, @remaining_routes);
      foreach my $elem (@tmp_results) {
         # each solution that we collect has the new length $len (temporary length
         # inside the start_route) + length of the found solution from the recursive
         # call. The path is the path inside the start_route (minus the last element
         # so we don't count the same node twice as it's also the start in the solution
         # from the recursive call)
         my @tmp = @path;
         pop @tmp;
         push @results, [ $len+$elem->[0], [ @tmp, @{ $elem->[1] } ] ];
      }
   }
   # Now the second half of the start_route where the destinations are after
   # the source
   foreach my $i ($start_position+1..$#start_route) {
      my $len = $i - $start_position;
      my @path = @start_route[$start_position..$i]; # no need to reverse the path here
      last if $i == $end_position; # if we happen to find our final destination we are done
      my $new_start = $start_route[$i];
      my @tmp_results = find_more_routes($new_start, $destination, @remaining_routes);
      foreach my $elem (@tmp_results) {
         # same as above, no need to duplicate that comment
         my @tmp = @path;
         pop @tmp;
         push @results, [ $len+$elem->[0], [ @tmp, @{ $elem->[1] } ] ];
      }
   }

   return @results;
}

# This helper function gets all permutations of an array and
# returns those at once. If we'd have to work on huge arrays,
# this should be turned into an iterator which returns
# one permutation per call
sub get_permutations {
   my @array = @_;
   return () unless @array;
   my @result;
   foreach my $i (0..$#array) {
      my @slices = ();
      push @slices, @array[0..$i-1] if $i > 0;
      push @slices, @array[$i+1..$#array] if $i < $#array;
      if(@slices) {
         foreach my $p (get_permutations(@slices)) {
            push @result, [ $array[$i], @$p ];
         }
      } else {
         push @result, [ $array[$i] ];
      }
   }
   return @result;
}

