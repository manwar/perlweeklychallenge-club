#!/usr/bin/perl

=begin comment

 Task #2 > Conflict Intervals
 ============================

 You are given a list of intervals.
 Write a script to find out if the current interval conflicts with any of the
 previous intervals.

 EXAMPLE
 Input: @intervals = ( [1, 4], [3, 5], [6, 8], [12, 13], [3, 20] );
 Output: ( [3, 5], [3, 20] )

   - The 1st interval [1, 4] does not have any previous intervals to compare
     with, so skip it.
   - The 2nd interval [3, 5] does conflict with previous interval [1, 4].
   - The 3rd interval [6, 8] does not conflict with any of the previous
     intervals [1, 4] and [3, 5], so skip it.
   - The 4th interval [12, 13] again does not conflict with any previous
     intervals [1, 4], [3, 5], or [6, 8] so skip it.
   - The 5th interval [3, 20] conflicts with the first interval [1, 4].

 Input: @intervals = ( [3, 4], [5, 7], [6, 9], [10, 12], [13, 15] );
 Output: ( [6, 9] );

=end comment
=cut

use strict;
use warnings;
use utf8;
use open ":std", ":encoding(UTF-8)";
use Term::ANSIColor;
use Scalar::Util qw( reftype );
use JSON qw( decode_json );

# Here, our subroutine to test our intervals (PWC solution)
sub find_conflict_intervals {
  my $set_ref = shift @_;
  my @conflicts = ();
  my @passed = ();
  if (reftype $set_ref ne "ARRAY") {
    print "Array reference not found\n";
    return 0;
  }
  foreach my $set (@$set_ref) {
    my ($a1, $a2) = sort { $a <=> $b } @$set;
    my $conflict = grep {
      my ($b1, $b2) = sort { $a <=> $b } @$_;
      ($a1 >= $b1 && $a1 <= $b2) ||
      ($a2 >= $b1 && $a2 <= $b2) ||
      ($a1 <= $b1 && $a2 >= $b2);
    } @passed;
    push @passed, [$a1, $a2] if not $conflict;
    push @conflicts, [$a1, $a2] if $conflict;
  }
  return \@conflicts;
}

# Followed by some utilities to test our solution

sub parse_test_case {
  my $filename = shift;

  open my $fh, "<", $filename
    or die "Could not open '$filename' - $!\n";
  read $fh, my $json, -s $fh;
  close $fh;
  my $data = decode_json $json;
  return $data;
}

sub sort_compare {
  return ($a->[0] <=> $b->[0]) || ($a->[1] <=> $b->[1]);
}

sub compare_interval_sets {
  my ($output, $compare) = @_;
  if (reftype $output ne "ARRAY" || reftype $compare ne "ARRAY") {
    print "Output not formatted correctly\n";
    return 0;
  }
  my $length = scalar @$output;
  if ($length != scalar @$compare) {
    return 0;
  }
  my @sorted_output = sort sort_compare @$output;
  my @sorted_compare = sort sort_compare @$compare;
  for my $i (0 .. $length) {
    my $test = $sorted_output[0];
    my $answer = $sorted_compare[0];
    if ($test->[0] != $answer->[0] || $test->[1] != $answer->[1]) {
      return 0;
    }
  }
  return 1;
}

sub assert_conflicts {
  my ($input, $output) = @_;
  my $compare = find_conflict_intervals $input;
  my $equal = compare_interval_sets $output, $compare;
  print color("green"), "Passed \x{2690}\n", color("reset") if $equal;
  print color("red"), "Failed \x{2715}\n", color("reset") if not $equal;
}

# And our test runner

sub main {
  my $target = shift @ARGV // "../test_cases/ch2";

  if (-e -r -f $target) {
    my $json = parse_test_case $target;
    my $input = %$json{"input"};
    my $output = %$json{"output"};
    print $target, ": ";
    assert_conflicts $input, $output;
    return;
  } elsif (-e -r -d _) {
    $target =~ s/^(.*?)\/?$/$1\//;     # check for trailing slash
    opendir my $dh, $target
      or die "Could not open '$target' - $!\n";
    my @entries = readdir $dh;
    foreach my $entry (@entries) {
      if ($entry eq "." or $entry eq "..") {
        next;
      }
      my $path = $target . $entry;
      my $json = parse_test_case $path;
      my $input = %$json{"input"};
      my $output = %$json{"output"};
      print $path, ": ";
      assert_conflicts $input, $output;
    }
    closedir $dh;
    return;
  } else {
    print "No test files found\n";
  }
}

main();
