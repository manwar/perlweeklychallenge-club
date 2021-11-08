#!/usr/bin/perl

=begin comment

 * ch-1.pl
 *
 * Task 1 > Odd Number
 * ===================
 *
 * You are given an array of positive integers, such that all the numbers appear
 * an even number of times except one number.
 *
 * Write a script to find that integer.
 *
 * Example 1
 * =========
 *
 * @input = (2, 5, 4, 4, 5, 5, 2);
 *
 * $output = 5; # as it appears 3 times in the array whereas all other numbers 2
 *              # and 4 appear exactly twice
 *
 * Example 2
 * =========
 *
 * @input = (1, 2, 3, 4, 3, 2, 1, 4, 4);
 *
 * $output = 4;

=end comment
=cut

use strict;
use warnings;
use utf8;
use open ":std", ":encoding(UTF-8)";
use Term::ANSIColor;

########################################
# Here, our input reducer (PWC solution)
########################################

sub reduce_to_odd {
  my $input_ref = shift;
  my %mapped;
  # First, we reduce our input to a hash of values and counts
  foreach my $entry (@$input_ref) {
    # If entry exists, increment count
    if (exists $mapped{$entry}) {
      $mapped{$entry}++;
      next;
    }
    # Else, initialize count
    $mapped{$entry} = 1;
  }
  # Technically, our challenge states that there will only ever be one odd input
  # count, but, just for fun, we'll design it to return all odd counts in case
  # we get improperly validated input.
  my @odd;
  foreach my $key (keys %mapped) {
    # Iterate through, pushing values with odd counts to our `odd` array
    if ($mapped{$key} % 2 != 0) {
      push(@odd, $key);
    }
  }
  my $result_count = scalar @odd;
  # Handle our possible results:
  if ($result_count == 0) {
    # Tricky input, no correct answer.
    return 'No odd counts found';
  }
  if ($result_count == 1) {
    # Input as expected, return correct answer
    return $odd[0];
  }
  # Incorrectly validated input.  Be the bigger person and just return all
  # correct answers as a reference to our `odd` array.
  return \@odd;
}

########################################
########################################

# Followed by some utilities to test our solution

sub parse_test_case {
  # Read input from a file path and convert it to array of inputs and an array
  # of expected answers.
  my $file_path = shift;
  my @inputs;      
  my @answers;

  open my $fh, '<', $file_path
    or die "Could not open '$file_path' - $!\n";

  while (my $line = <$fh>) {
    chomp $line;
    # Skip comments
    next if $line =~ /^\s*#/;
    # Trim whitespace
    $line =~ s/^\s+|\s+$//g;
    # If there are more inputs than answers, push line to answers array.
    if (scalar @inputs > scalar @answers) {
      push(@answers, $line);
      next;
    }
    # Split and trim input line
    my @input_arr = map {
      my $value = $_;
      $value =~ s/^\s+|\s+$//g;
      $value;
    } split /\s*,\s*/, $line;
    # Push ref to our `inputs` array
    push @inputs, \@input_arr;
  }
  return (\@inputs, \@answers);
}

sub assert_match {
  # Test individual input sets against expected answer using our PWC Solution
  my ($inputs_ref, $expected) = @_;
  # Here we test our solution
  my $result = reduce_to_odd($inputs_ref);
  # Print the input to the console to show the running test
  print "\nInput: ", join(", ", @$inputs_ref), "\n";
  # Handle single answer 
  if (!ref $result) {
    # Show the expected answer and the answer received
    print "Expected: ", $expected, "\n";
    print "Result: ", $result, "\n";
    # Check for match
    if ($result eq $expected) {
      # Match
      print color("green"), "Passed \x{2690}\n", color("reset");
      return;
    }
    # Fail
    print color("red"), "Failed \x{2715}\n", color("reset");
    return;
  }
  # Handle multiple answers
  if (ref $result eq "ARRAY") {
    # Sort expected results to make it easier to compare
    my @expected_results = sort {$a cmp $b} map {
      my $entry = $_;
      # Strip whitespace
      $entry =~ s/^\s+|\s+$//g;
      $entry;
    } split /\s*,\s*/, $expected;
    # Sort our received results to compare directly 
    my @sorted_results = sort {$a cmp $b} @$result;
    # Shows the expected results and the results received 
    print "Expected: ", join(", ", @expected_results), "\n";
    print "Result: ", join(", ", @sorted_results), "\n";
    # Check for pass
    my $passed = 1;
    # compare each element of the two arrays
    foreach my $idx (0 .. $#expected_results) {
      # if all indexes match, pass
      unless ($sorted_results[$idx] eq $expected_results[$idx]) {
        $passed = 0;
      }
    }
    # Double check in case something goes really wrong
    my $matching_lengths = scalar @expected_results == scalar @sorted_results;
    # Pass
    if ($passed and $matching_lengths) {
      print color("green"), "Passed \x{2690}\n", color("reset");
      return;
    }
    # Fail
    print color("red"), "Failed \x{2715}\n", color("reset");
  }
}

# And our test runner

sub main {
  # Takes a command line argument as a path to a file or directory of files to
  # parse and test.  Falls back to our sample tests.
  my $target = shift @ARGV // "../test_cases/ch-1";
  # Check if path is a single file
  if (-e -r -f $target) {
    # Parse file into inputs and answers
    my ($inputs_ref, $answers_ref) = parse_test_case $target;
    # Print the path to the console
    print $target, "\n";
    print "=====================================\n";
    # Iterate through parse tests and assert matches    
    foreach my $idx (0 .. $#$answers_ref) {
      assert_match($inputs_ref->[$idx], $answers_ref->[$idx]);
    }
    return;
  } elsif (-e -r -d _) {
    # Path is directory, check for trailing slash
    $target =~ s/^(.*?)\/?$/$1\//;
    # Open and read file names from directory
    opendir my $dh, $target
      or die "Could not open '$target' - $!\n";

    my @entries = readdir $dh;
    # close
    closedir $dh;
    # Iterate through test cases
    foreach my $entry (sort @entries) {
      # Skip "." and ".."
      if ($entry eq "." or $entry eq "..") {
        next;
      }
      # concat path and file name
      my $path = $target . $entry;
      # Parse our tests
      my ($inputs_ref, $answers_ref) = parse_test_case $path;
      # Print path to console
      print $path, "\n";
      print "=====================================\n";
      # Iterate and compare
      foreach my $idx (0 .. $#$answers_ref) {
        assert_match($inputs_ref->[$idx], $answers_ref->[$idx]);
      }
      print "\n\n";
    }
  } else {
    print "No test files found at $target\n";
  }
}

main();
