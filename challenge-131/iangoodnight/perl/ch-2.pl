#!/usr/bin/perl
# ch-2.pl

=begin summary

 * https://theweeklychallenge.org/blog/perl-weekly-challenge-131/
 *
 * Task 2 > Find Pairs
 * ===================
 *
 * You are given a string of delimiter pairs and a string to search.
 *
 * Write a script to return two strings the first with any characters matching
 * the "opening character" set, the second with any matching the "closing
 * character" set.
 *
 * Example 1:
 *
 * Input:
 *
 *  Delimiter pairs: ""[]()
 *
 *  Search String: "I like (parens) and the Apple ][+" they said.
 *
 * Output:
 *
 *  "(["
 *
 *  "])"
 *
 * Example 2:
 *
 * Input:
 *
 *  Delimiter pairs: **//<>
 *
 *  Search String: /* This is a comment (in some languages) * / <could be a tag>
 *
 *  Output:
 *   /**/<
 *   /**/>

=end summary
=cut

use strict;
use warnings;
use utf8;

#################################################
# Here, our Find Delims subroutine (PWC Solution)
#################################################

sub find_delims {
  my ( $delim_string, $search_string ) = @_;
  my @delims = split //, $delim_string;
  my @open_set;
  my @close_set;

  # Partion delimiters into openings and closings
  foreach my $idx ( 0 .. $#delims ) {
    my $char = $delims[$idx];
    if ( $idx % 2 ) {
      push @close_set, $char;
    }
    else {
      push @open_set, $char;
    }
  }

  my @search = split //, $search_string;
  my @found_open;
  my @found_close;

  foreach my $char (@search) {
    if ( grep { $_ eq $char } @open_set ) {
      push @found_open, $char;
    }
    if ( grep { $_ eq $char } @close_set ) {
      push @found_close, $char;
    }
  }

  return ( \@found_open, \@found_close );
}

#################################################
#################################################
#
#################################################
# Utilities
#################################################

sub print_results {
  my @results = @_;
  foreach (@results) {
    print join( q{}, @{$_} ), "\n";
  }
  return;
}

#################################################
#################################################
#
#################################################
# And our CLI
#################################################

sub main {
  while (1) {
    print "Welcome to delimiter search (type 'exit' or Ctrl+c to quit).\n";
    print q{Please provide delimiter string (ie: ''[]{}<>**): };
    my $delimiter_string = <>;
    chomp $delimiter_string;
    $delimiter_string =~ s/^\s+|\s+$//gm;
    last if $delimiter_string eq 'exit';
    print 'Please provide search string: ';
    my $search_string = <>;
    chomp $search_string;
    last if $search_string eq 'exit';
    print "Results:\n";
    print_results find_delims $delimiter_string, $search_string;
  }
  return;
}

main();

