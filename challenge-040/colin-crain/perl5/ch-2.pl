#! /opt/local/bin/perl
#
#       subsort.pl
#
#       PWC 40 - TASK #2
#       Sort SubList
#           You are given a list of numbers and set of indices belong to the
#           list. Write a script to sort the values belongs to the indices.
#
#           For example,
#
#               List: [ 10, 4, 1, 8, 12, 3 ]
#               Indices: 0,2,5
#           We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.
#
#           Final List would look like below:
#
#               List: [ 1, 4, 3, 8, 12, 10 ]
#
#       method: Another puzzle from the list-processsing world! But like many
#           confusing data structure problems, the answer reveals itself by
#           first figuring out what the real question is. As such, this is
#           dispatched in what amounts to two lines of code: in the first line
#           we get the values at the indices specified from the original list
#           and sort them; in the second line we alter the original list in
#           place using the splice function, shifting our sorted values off
#           one by one as we iterate through the specifying indices.
#
#           One point of possible confusion in this challenge is the use of the
#           word "set" in the specification of the indices, rather than "list".
#           In mathematics set theory decribes the behavior of collections of
#           items that either do or do not belong to a set; the order of the
#           items is not normally considered. As such it will be understood that
#           the sorted elements will be defined by the given indices taken as a
#           whole, irrespective of the order those elements are delivered. By
#           first sorting the list of indices we establish that the insertions
#           into the master list will be made in a well defined, increasing
#           order, synchronized with our list of sorted elements.
#
#           The indices will be assumed to be numbers, the main elements will
#           be sorted first numerically, then semantically if applicable.
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $list    = [ 10, 4, 1, 8, 12, 3 ];
my $indices = [ 0, 5, 2 ];

## presort the index set to make an ordered list from low to high
my @indices = sort { $a <=> $b } $indices->@*;

# OUTPUT
#
say "prechange list  : [ ", (join ', ', $list->@*), " ]";

## we get the values at the indices specified from the original list and sort
my @sorted = sort {$a <=> $b || $a cmp $b } map { $list->[$_] } @indices;

## reinsert the sorted data
splice( $list->@*, $_, 1, shift @sorted ) for @indices ;

# OUTPUT
#
say "postchange list : [ ", (join ', ', $list->@*), " ]";
