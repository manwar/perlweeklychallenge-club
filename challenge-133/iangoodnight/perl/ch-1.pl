#!/usr/bin/perl
# ch-1.pl

=begin comment

 * https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
 *
 * Task 1 > Integer Square Root
 * ============================
 *
 * You are given a positive integer `$N`.
 *
 * Write a script to calculate the integer square root of the given number.
 *
 * Please avoid using built-in function.  Find out more about it here
 * (https://en.wikipedia.org/wiki/Integer_square_root).
 *
 * Examples
 * --------
 *
 * Input: $N = 10
 * Output: 3
 *
 * Input: $N = 27
 * Output: 5
 *
 * Input: $N = 85
 * Output: 9
 *
 * Input: $N = 101
 * Output: 10

=end comment
=cut

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Term::ANSIColor;

################################################################################
# Our PWC Solution
################################################################################

sub return_int_sqr_root {
  my $input = shift;
  chomp $input;

  # Validate input
  $input =~ s{
    ^\s+ # Leading whitespace
    |
    \s+$ # Trailing whitespace
  }{}gmx;
  if ( !$input =~ /^\d+$/m ) {
    return;
  }

  # Crawl through squares starting with 0
  my $i = 0;
  while ( $i * $i <= $input ) {
    $i++;
  }

  # Return the highest passing number
  return --$i;
}

################################################################################
# Utilities
################################################################################

sub print_banner {
  my $message  = 'Integer Square Root Calculator';
  my $border   = q{=} x length $message;
  my $empty    = q{};
  my @elements = ( $empty, $border, $message, $border, $empty, $empty );

  return print color('cyan'), join( "\n", @elements ), color('reset');
}

################################################################################
# REPL
################################################################################

sub main {
  my $prompt =
      'Enter a positive integer (or, type "'
    . color('yellow') . 'exit'
    . color('reset')
    . '" to quit)> ';

  my $retry =
      'Try again? ('
    . color('yellow') . 'y'
    . color('reset') . q{/}
    . color('yellow') . 'n'
    . color('reset') . ')> ';

  print_banner();
  print $prompt;

  my $complete = 0;

  while ( my $line = <> ) {
    chomp $line;
    $line =~ s{
      ^\s+ # Remove leading whitespace
      |
      \s+$ # Remove trailing whitespace
    }{}gmx;

    if ( $line eq 'exit' || $line eq 'n' ) {
      print "Goodbye.\n";
      return 1;
    }
    if ( $line eq 'y' ) {
      $complete = 0;
      print $prompt;
      next;
    }
    if ( $line =~ m/^\d+$/m && !$complete ) {
      print 'Integer square root: ';
      print color('yellow'), return_int_sqr_root($line), color('reset'), "\n";
    }
    elsif ($complete) {
      print "\n", $retry;
    }
    else {
      print "Arguments must be positive integers only.\n";
    }

    $complete = 1;
    print $retry;
  }
  return 1;
}

main();
