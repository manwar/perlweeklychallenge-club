#!/usr/bin/perl
# ch-1.pl

=begin comment

  > https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
 
  ## Task2 > Palindromic Tree
  ===========================
 
  You are given a string `$s`.
 
  Write a script to create a `Palindromic Tree` for the given string
 
  I found this [blog] explaining `Palindromic Tree` in detail.
 
  **Example 1:**
 
  ```
  Input: $s = 'redivider'
  Output: r redivider e edivide d divid i ivi v
  ```
 
  **Example 2:**
 
  ```
  Input: $s = 'deific'
  Output: d e i ifi f c
  ```
 
  **Example 3:**
 
  ```
  Input: $s = 'rotors'
  Output: r rotor o oto t s
  ```
 
  **Example 4:**
 
  ```
  Input: $s = 'challenge'
  Output: c h a l ll e n g
  ```
 
  **Example 5:**
 
  ```
  Input: $s = 'champion'
  Output: c h a m p i o n
  ```
 
  **Example 6**
 
  ```
  Input: $s = 'christmas'
  Output: c h r i s t m a
  ```
 
  [blog]: https://medium.com/@alessiopiergiacomi/eertree-or-palindromic-tree-82453e75025b

=end comment
=cut

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

################################################################################
# PWC Solution #################################################################
################################################################################

sub is_palindrome {
  my $string   = shift;
  my $reversed = reverse $string;

  return $string eq $reversed ? 1 : 0;
}

# The blog mentioned in the challenge description describes a pretty interesting
# data structure to tackle this challenge.  My approach here is not nearly as
# nice.
sub eertree {
  my $input_str = shift;
  my $length    = length $input_str;
  my @palindromes;
  my %map;

  for my $cursor ( 0 .. $length - 1 ) {
    my $chars = 1;

    while ( $chars <= $length - $cursor ) {
      my $substring = substr $input_str, $cursor, $chars;

      if ( is_palindrome($substring) ) {
        push @palindromes, $substring unless exists $map{$substring};
        $map{$substring} = 1;
      }

      $chars += 1;
    }
  }

  return join q{ }, @palindromes;
}

################################################################################
# Utilities ####################################################################
################################################################################

sub trim {
  my $string = shift;
  $string =~ s/ \A \s+ | \s+ \z //x;
  return $string;
}

sub parse_test_case {
  my $filename = shift;

  open my $fh, '<', $filename
    or die "Could not open '$filename' - $!\n";

  my $data = do { local $/ = undef; <$fh> };

  close $fh;

  my ( $input, $test ) = map { trim $_ }
    grep { m/ \A \s* [^#] .* \z /sx; } split / \n /x, $data;

  return ( $input, $test );
}

sub print_params {
  my $params = shift;

  print $params->{target}, ":\n";
  print "Input: \$s = $params->{input}\n";
  print "Output: $params->{test}\n";

  return 1;
}

sub test_solution {
  my $solution = shift;
  my $params   = shift;
  my $result   = $solution->( $params->{input} );

  if ( $params->{test} eq $result ) {
    print "\e[32mPassed \x{2690}\e[0m\n\n";
    return 1;
  }
  print "\e[31mFailed \x{2715}\e[0m\n\n";
  return 0;
}

################################################################################
# Main #########################################################################
################################################################################

my $target = shift @ARGV // '../test_cases/ch-2/';

if ( -e -r -f $target ) {
  my ( $input, $test ) = parse_test_case($target);
  my %params = (
    input  => $input,
    target => $target,
    test   => $test,
  );
  print_params \%params;
  test_solution( \&eertree, \%params );
}
elsif ( -e -r -d _ ) {
  $target =~ s/ \A ( .*?  ) \/? \z /$1\//x;

  opendir my $dh, $target
    or die "Could not open '$target' - $!\n";

  my @entries = readdir $dh;

  closedir $dh;

  for my $entry ( sort @entries ) {
    if ( $entry eq q{.} or $entry eq q{..} ) {
      next;
    }

    my $path = $target . $entry;
    my ( $input, $test ) = parse_test_case($path);
    my %params = (
      input  => $input,
      target => $path,
      test   => $test,
    );
    print_params \%params;
    test_solution( \&eertree, \%params );
  }
}
else {
  print "Something went wrong.  No test cases found at $target\n";
}
