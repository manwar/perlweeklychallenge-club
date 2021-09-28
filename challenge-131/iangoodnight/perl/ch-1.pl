#!/usr/bin/perl
# ch-1.pl

=begin comment

 * https://theweeklychallenge.org/blog/perl-weekly-challenge-131/
 *
 * Task 1 > Consecutive Arrays
 * ===========================
 *
 * You are given a sorted list of unique positive integers.
 *
 * Write a scipt to return lists of arrays where the arrays are consecutive
 * integers.
 *
 * Example 1:
 *
 * my @input = (1, 2, 3, 6, 7, 8, 9);
 *
 * my @output = ([1, 2, 3], [6, 7, 8, 9]);
 *
 * Example 2:
 *
 * my @input = (11, 12, 14, 17, 18, 19);
 *
 * my @output = ([2], [4], [6], [8]);
 *
 * Example 3:
 *
 * my @input = (2, 4, 6, 8);
 *
 * my @output = ([2], [4], [6], [8]);
 *
 * Example 4:
 *
 * my @input = (1, 2, 3, 4, 5);
 *
 * my @output = ([1, 2, 3, 4, 5]);

=end comment
=cut

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Term::ANSIColor;

###################################################
# Here our Consecutive Array reducer (PWC Solution)
###################################################

sub reduce_to_consecutive {
  my @input = @{ +shift };
  my @reduced;

  foreach my $element (@input) {

    # if `@reduced` is empty, push the first element as part of an anonymous
    # list to start our comparisons
    if ( not( scalar @reduced ) ) {
      push @reduced, [$element];
      next;
    }

    # grab a copy of the last element checked to test if consecutive
    my $last_element = $reduced[-1]->[-1];

    # increment $last_element and compare to current element
    if ( ++$last_element eq $element ) {

      # if matched, push the current element to the last set
      push @{ $reduced[-1] }, $element;
      next;
    }

    # Else, push it as part of a new set.
    push @reduced, [$element];
  }
  return \@reduced;
}

###################################################
###################################################
#
###################################################
# Followed by some utilities to test our solution
###################################################

sub eval_input {
  my $input = shift;

  # If no inner sets, return the split string as an array reference
  if ( not( $input =~ /\[/ ) ) {

    # Strip outer parenthesis
    $input =~ s/[(]|[)]//g;

    # split by comma and optional spaces
    return [ map { int } split /\s*,\s*/, $input ];
  }

  # Else, return a reference to an array of sets
  return [
    map {
      [ map { int } split /\s*,\s*/ ]
      } $input =~ m{
      \[       # opening bracket
      ([^\]]*) # inner set
      \]       # closing bracket
    }gx
  ];
}

sub parse_test_case {

  # Parse file into arrays of inputs and answers
  my $file_path = shift;
  my @inputs;
  my @answers;

  open my $fh, '<', $file_path
    or die "Could not open '$file_path' - $!\n";

  while ( my $line = <$fh> ) {
    chomp $line;

    # Skip comments
    next if $line =~ /^\s*#|^\s*$/m;

    # Trim whitespace
    $line =~ s/^\s+|\s+$//gm;

    # Parse line into list reference
    my $parsed = eval_input $line;

    # If there are more inputs than answers, assume line is an answer
    if ( scalar @inputs > scalar @answers ) {
      push @answers, $parsed;
      next;
    }

    # Else, assume it an input
    push @inputs, $parsed;
  }
  return ( \@inputs, \@answers );
}

sub assert_deep_match {
  my @first_list  = @{ +shift };
  my @second_list = @{ +shift };
  my $match       = 1;

  # If lengths don't match, fail
  if ( scalar @first_list != scalar @second_list ) {
    return 0;
  }

  # Check each element
  foreach my $idx ( 0 .. $#first_list ) {
    my $ref = ref $first_list[$idx];

    # if element is a scalar check for match
    if ( $ref ne 'ARRAY' && $first_list[$idx] ne $second_list[$idx] ) {
      $match = 0;
    }

    # if element is an array recurse
    if ( $ref eq 'ARRAY' ) {
      my $recursed = assert_deep_match( $first_list[$idx], $second_list[$idx] );
      $match = $recursed;
    }

    # Quit early
    last if not $match;
  }
  return $match;
}

sub deep_print {
  my @input = @{ +shift };

  foreach my $idx ( 0 .. $#input ) {
    my $el  = $input[$idx];
    my $ref = ref $el;

    if ( $ref eq 'ARRAY' ) {
      print '[';
      deep_print($el);
      print ']';
    }
    else {
      print $el;
    }
    if ( $idx != $#input ) { print ', ' }
  }
  return;
}

sub print_results {
  my $test_path = shift;
  my @inputs    = @{ +shift };
  my @answers   = @{ +shift };

  print $test_path, "\n";
  print '=' x length($test_path), "\n\n";

  foreach my $idx ( 0 .. $#inputs ) {
    my $input = $inputs[$idx];

    # Check for empty array (just to be safe)
    next if scalar @{$input} == 0;

    my $answer = $answers[$idx];
    my $result = reduce_to_consecutive $input;

    print 'Input: (', join( ', ', @{$input} ), ")\n";
    print 'Expected: (';
    deep_print($answer);
    print ")\n";
    print 'Result: (';
    deep_print($result);
    print ")\n";

    if ( assert_deep_match( $answer, $result ) ) {
      print color('green'), "Passed \x{2690}\n", color('reset');
    }
    else {
      print color('red'), "Failed \x{2715}\n", color('reset');
    }
    print "\n";
  }
  print "\n";
  return;
}

###################################################
###################################################
#
###################################################
# And our test runner
###################################################

sub main {
  my $target = shift @ARGV // '../test_cases/ch-1';

  # Handle single file target
  if ( -e -r -f $target ) {
    my ( $inputs_array, $answers_array ) = parse_test_case $target;
    print_results $target, $inputs_array, $answers_array;
    return;
  }

  # Handle directory target
  if ( -e -r -d _ ) {

    # Check for trailing slash
    $target =~ s/^(.*?)\/?$/$1\//ms;

    opendir my $dh, $target
      or die "Could not open '$target' - $!\n";

    my @entries = readdir $dh;
    closedir $dh;

    foreach my $entry ( sort @entries ) {

      # Skip the garbage
      next if $entry eq '.' or $entry eq '..';
      my $path = $target . $entry;
      my ( $inputs_array, $answers_array ) = parse_test_case $path;
      print_results $path, $inputs_array, $answers_array;
    }
    return;
  }
  else {
    print "No tests found at $target\n";
  }
  return;
}

main();

