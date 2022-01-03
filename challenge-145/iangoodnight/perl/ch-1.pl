#!/usr/bin/perl
# ch-1.pl

=begin comment

  > https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
  
  ## Task 1 > Dot Product
  =======================
  
  You are given 2 arrays of the same size, `@a` and `@b`.
  
  Write a script to implement `Dot Product`.
  
  **Example:**
  ```
  @a = (1, 2, 3);
  @b = (4, 5, 6);
  
  $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32
  ```

=end comment
=cut

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

################################################################################
# PWC Solution #################################################################
################################################################################

sub dot_product {

  my @arr_1 = @{ +shift };
  my @arr_2 = @{ +shift };

  my $sum = 0;

  for my $idx ( 0 .. $#arr_1 ) {
    $sum += $arr_1[$idx] * $arr_2[$idx];
  }
  return $sum;
}

################################################################################
# Utilities ####################################################################
################################################################################

sub nums_from_string {
  my $string = shift;

  return [ map { $_ * 1 } split / \s* , \s* /x, $string ];
}

sub parse_test_case {
  my $filename = shift;
  my $arr_1;
  my $arr_2;
  my $test;

  open my $fh, '<', $filename
    or die "Could not open '$filename' - $!\n";

  while ( my $line = <$fh> ) {
    chomp $line;

    next if $line =~ m/ \A \s* \# /x;

    $line =~ s/ \A \s+ | \s+ \z //gx;

    if ( !defined $arr_1 ) {
      $arr_1 = nums_from_string($line);
      next;
    }

    if ( !defined $arr_2 ) {
      $arr_2 = nums_from_string($line);
      next;
    }

    $test = $line * 1;
  }

  close $fh;

  return ( $arr_1, $arr_2, $test );
}

sub test_solution {
  my $callback = shift;
  my @args     = @{ +shift };
  my $test     = shift;

  my $result = &$callback(@args);

  if ( $test == $result ) {
    print "\e[32mPassed \x{2690}\e[0m\n";
    return 1;
  }
  print "\e[31mFailed \x{2715}\e[0m\n";
  return 0;
}

sub print_arguments {
  my ( $target, $a, $b, $test ) = @_;

  print $target, ":\n";
  print '@a = ', join( ', ', @$a ), "\n";
  print '@b = ', join( ', ', @$b ), "\n";
  print "Dot Product: $test\n";

  return 1;
}

################################################################################
# Main #########################################################################
################################################################################

sub main {
  my $target = shift @ARGV // '../test_cases/ch-1';

  if ( -e -r -f $target ) {
    my ( $arr_1, $arr_2, $test ) = parse_test_case $target;

    print_arguments( $target, $arr_1, $arr_2, $test );
    test_solution( \&dot_product, [ $arr_1, $arr_2 ], $test );
    print "\n";
  }
  elsif ( -e -r -d _ ) {
    $target =~ s/ \A ( .*? ) \/? \z /$1\//x;

    opendir my $dh, $target
      or die "Could not open '$target' - $!\n";

    my @entries = readdir $dh;

    closedir $dh;

    foreach my $entry ( sort @entries ) {
      if ( $entry eq q{.} or $entry eq q{..} ) {
        next;
      }

      my $path = $target . $entry;
      my ( $arr_1, $arr_2, $test ) = parse_test_case $path;

      print_arguments( $path, $arr_1, $arr_2, $test );
      test_solution( \&dot_product, [ $arr_1, $arr_2 ], $test );
      print "\n";
    }
  }
  else {
    print "No test files found at $target\n";
  }

  return 0;
}

main();
