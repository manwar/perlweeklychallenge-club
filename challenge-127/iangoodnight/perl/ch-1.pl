#!/usr/bin/perl

=begin comment

 Task #1 > Disjoint Sets
 =======================

 You are given two sets with unique integers.
 Write a script to figure out if they are disjoint.

 The two sets are disjoint if they don't have any common members

 EXAMPLE
 Input: @s1 = (1, 2, 5, 3, 4);
        @s2 = (4, 6, 7, 8, 9);
 Output: 0 as the given sets have common member 4.

 Input: @s1 = (1, 3, 5, 7, 9);
        @s2 = (0, 2, 4, 6, 8);
 Output: 1 as the given two sets do no have a common member

=end comment
=cut

use strict;
use warnings;
use utf8;
use open ":std", ":encoding(UTF-8)";
use Term::ANSIColor;

# Here, our subroutine to test our sets (PWC solution)

sub is_disjoint {
  my ($set1_ref, $set2_ref) = @_;
  my @test_set = @$set1_ref;
  my %haystack = map { $_ => 1 } @$set2_ref;
  my $disjoint = 1;
  while ($disjoint and scalar @test_set) {
    my $needle = pop(@test_set);
    $disjoint = 0 if exists($haystack{$needle});
  }
  return $disjoint;
}

# Followed by some utilities to test our solution

sub parse_test_case {
  my $filename = shift;
  my $first_line = "";
  my $second_line = "";
  my $test = "";

  open my $fh, "<", $filename
    or die "Could not open '$filename' - $!\n";

  while (my $line = <$fh>) {
    chomp $line;
    next if $line =~ /^#/;
    unless (length $first_line) {
      $first_line = $line;
      next;
    }
    unless (length $second_line) {
      $second_line = $line;
      next;
    }
    if ($line eq "1" || $line eq "0") {
      $test = int($line);
      last;
    }
  }
  close $fh;
  my @first_set = split /\s*,\s*/, $first_line;
  my @second_set = split /\s*,\s*/, $second_line;

  return (\@first_set, \@second_set, $test);
}

sub assert_disjoint {
  my ($set1_ref, $set2_ref, $test) = @_;
  my $disjoint = is_disjoint($set1_ref, $set2_ref);
  if ($test eq $disjoint) {
    print color("green"), "Passed \x{2690}\n", color("reset");
  } else {
    print color("red"), "Failed \x{2715}\n", color("reset");
  }
}

# And our test runner

sub main {
  my $target = shift @ARGV // "../test_cases/ch1";

  if (-e -r -f $target) {                # handle file target
    my ($set1_ref, $set2_ref, $test) = parse_test_case $target;

    print $target, ": ";
    assert_disjoint $set1_ref, $set2_ref, $test;
    return;
  } elsif (-e -r -d _) {               # handle directory target
    $target =~ s/^(.*?)\/?$/$1\//;     # check for trailing slash
    opendir my $dh, $target
      or die "Could not open '$target' - $!\n";
    my @entries = readdir $dh;
    foreach my $entry (@entries) {
      if ($entry eq '.' or $entry eq '..') {
        next;
      }
      my $path = $target . $entry;
      my ($set1_ref, $set2_ref, $test) = parse_test_case $path;
      print $path, ": ";
      assert_disjoint $set1_ref, $set2_ref, $test;
    }
    closedir $dh
  } else {
    print "No test files found\n";
  }
}

main();
