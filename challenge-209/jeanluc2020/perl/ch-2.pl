#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-209/#TASK2
#
# Task 2: Merge Account
# =====================
#
# You are given an array of accounts i.e. name with list of email addresses.
#
# Write a script to merge the accounts where possible. The accounts can only be merged if they have at least one email address in common.
#
# Example 1:
#
# Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                      ["B", "b1@b.com"],
#                      ["A", "a3@a.com", "a1@a.com"] ]
#
# Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
#           ["B", "b1@b.com"] ]
#
# Example 2:
#
# Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                      ["B", "b1@b.com"],
#                      ["A", "a3@a.com"],
#                      ["B", "b2@b.com", "b1@b.com"] ]
#
# Output: [ ["A", "a1@a.com", "a2@a.com"],
#           ["A", "a3@a.com"],
#           ["B", "b1@b.com", "b2@b.com"] ]
#
############################################################
##
## discussion
##
############################################################
#
# This is a bit a tricky one. When we walk through the input,
# we can either merge directly to a previous element in the
# output, or we have to append a new element to the output.
# Since corner cases are not considered, there are a few funny
# ones. What do we do if there is no common email address for
# two elements with the same name, but a third element in the
# list has an email address in common with both previous elements?
# We can then either merge with the first, or we could merge all
# three elements - since the task is unclear here, let's implement
# both solutions as alternatives

use strict;
use warnings;
use Data::Dumper;

my @accounts = (
   ["A", "a1\@a.com", "a2\@a.com"],
   ["B", "b1\@b.com"],
   ["A", "a3\@a.com", "a1\@a.com"]
);
merge_accounts(@accounts);
merge_accounts_full(@accounts);

@accounts = (
   ["A", "a1\@a.com", "a2\@a.com"],
   ["B", "b1\@b.com"],
   ["A", "a3\@a.com"],
   ["B", "b2\@b.com", "b1\@b.com"]
);
merge_accounts(@accounts);
merge_accounts_full(@accounts);

@accounts = (
   ["A", "a1\@a.com", "a2\@a.com"],
   ["B", "b1\@b.com"],
   ["A", "a3\@a.com"],
   ["B", "b2\@b.com", "b1\@b.com"],
   ["A", "a3\@a.com", "a2\@a.com"],
);
merge_accounts(@accounts);
merge_accounts_full(@accounts);

# helper function: merge the accounts in the given array
# this doesn't merge fully, only if an element already
# has a matching email address in a previous element
# returns the merged array
# This function only does the actual merging, nothing else
sub merge_accounts_ {
   my $accounts = shift;
   my $result = [];
   foreach my $elem (@$accounts) {
      my $did_merge = 0;
      # if there is an element in the current result set
      # that we can merge to, we do that, otherwise we'll
      # just add a new element to the result
      foreach my $i (0..$#$result) {
         if (can_merge_to($elem, $result->[$i])) {
            $result->[$i] = merge($result->[$i], $elem);
            $did_merge = 1;
            last;
         }
      }
      push @$result, $elem unless $did_merge;
   }
   return $result;
}

# helper function to do the actual merging
# Just add each email address to the first
# element unless it's there
# The name will also not be added because it's
# already there, no need for special treatment here
sub merge {
   my ($elem1, $elem2) = @_;
   my $seen;
   map { $seen->{$_} = 1 } @$elem1;
   foreach my $part (@$elem2) {
      next if $seen->{$part};
      push @$elem1, $part;
   }
   return $elem1;
}

# check whether we can merge two elements
# first, we need to check that name is the same
# then we need to find at least one matching email address
sub can_merge_to {
   my ($elem1, $elem2) = @_;
   my $seen;
   map { $seen->{$_} = 1 } @$elem1;
   my $name = $elem2->[0];
   return 0 unless $name eq $elem1->[0];
   foreach my $part (@$elem2) {
      next if $part eq $name;
      return 1 if $seen->{$part};
   }
   return 0;
}

# merge accounts from list when possible, not doing the deep
# re-merge if possible. This function does some output and
# otherwise calls merge_accounts_ for the actual work
sub merge_accounts {
   my $accounts = [ @_ ];
   print "Input: [";
   foreach my $elem (@$accounts) {
      print " [" . join(", ", @$elem) . "]\n";
   }
   print "]\n";

   my $merged = merge_accounts_($accounts);

   print "Output: [";
   foreach my $elem (@$merged) {
      print " [" . join(", ", @$elem) . "]\n";
   }
   print "]\n";
}

# this is the "full merge" option. We simply merge as before,
# but this time, as long as input and output of the actual
# merge step differ, we will start over with the current output
# as the new input. So we merge unless there is no more possibilty
# to merge anything
sub merge_accounts_full {
   my $accounts = [ @_ ];
   print "Input: [";
   foreach my $elem (@$accounts) {
      print " [" . join(", ", @$elem) . "]\n";
   }
   print "]\n";

   my $merged = merge_accounts_($accounts);

   while(is_same_deeply($accounts, $merged) == 0) {
      $accounts = $merged;
      $merged = merge_accounts_($accounts);
   }

   print "Output: [";
   foreach my $elem (@$merged) {
      print " [" . join(", ", @$elem) . "]\n";
   }
   print "]\n";
}

# helper function
# check if two nested arrays have the same elements at the bottom
sub is_same_deeply {
   my ($list1, $list2) = @_;
   if(scalar(@$list1) != scalar(@$list2)) {
      return 0;
   }
   # two empty lists are the same
   return 1 unless @$list1;
   foreach my $i (0..$#$list1) {
      if(ref($list1->[$i]) ne ref($list2->[$i])) {
         return 0;
      }
      if(ref($list1->[$i]) eq "ARRAY") {
         return 0 unless is_same_deeply($list1->[$i], $list2->[$i]);
      }
   }
   return 1;
}

