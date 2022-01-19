#!/usr/bin/perl
# ch-2.pl

=begin comment

  https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
 
  ## Task 2 > Curious Fraction Tree
  =================================
 
  Consider the following `Curious Fraction Tree`:
 
  ```
                 __________1/1__________
                /                       \
          ___1/2___                   ___2/1___
         /         \                 /         \
      1/3           3/2           2/3           3/1
     /   \         /   \         /   \         /   \
  1/4     4/3   3/5     5/2   2/5     5/3   3/4     4/1
  ```
 
  You are given a fraction, member of the tree created similar to the above
  sample.
 
  Write a script to find out the parent and grandparent of the given member.
 
  **Example 1:**
 
  ```
  Input: $member = '3/5';
  Output: parent = '3/2' and grandparent = '1/2'
  ```
 
  **Example 2:**
 
  ```
  Input: $member = '4/3';
  Output: parent = '1/3' and grandparent = '1/2'
  ```

=end comment
=cut

use strict;
use warnings;

################################################################################
# PWC Solution #################################################################
################################################################################

sub is_fraction_string {
  my $string = shift;

  if ( $string =~ m{ \A \s* \d+ / \d+ \s* \z }x ) {
    $string =~ s/ \A \s+ | \s+ \z//gx;
    return $string;
  }
  return 0;
}

sub get_curious_parent {
  my $member   = shift;
  my $fraction = is_fraction_string $member;

  die qq{`get_curious_parent` expects a string (i.e.: "3/5"), got $member\n}
    unless $fraction;

  my ( $num, $den ) = split qr{ / }x, $fraction;
  my $quotient = $num / $den;

  if ( $quotient > 1 ) {
    return ( $num - $den ) . q{/} . $den;
  }
  if ( $quotient < 1 ) {
    return $num . q{/} . ( $den - $num );
  }
  return 0;
}

sub get_curious_tree {
  my $member   = shift;
  my $fraction = is_fraction_string $member;

  die qq{`get_curious_tree` expects a string (i.e.: "3/5"), got $member\n}
    unless $fraction;

  my @parents;
  my $child = $fraction;

  while ($child) {
    push @parents, $child;
    $child = get_curious_parent $child;
  }

  return \@parents;
}

sub get_curious_generations {
  my @tree        = @{ +shift };
  my $generations = shift // 2;

  if ( scalar @tree == 2 ) {
    return [ $tree[1] ];
  }

  my @slice = @tree[ 1 .. $generations ];

  return \@slice;
}

################################################################################
# Utilities ####################################################################
################################################################################

sub color {
  my $color  = shift;
  my $str    = shift // q{};
  my $reset  = "\e[0m";
  my %colors = (
    green  => "\e[32m",
    none   => q{},
    red    => "\e[31m",
    yellow => "\e[33m",
  );
  return $colors{$color} . $str . $reset;
}

sub format_results {
  my @tree    = @{ +shift };
  my $length  = @tree;
  my $results = q{};

  for my $idx ( 0 .. $#tree ) {
    my $relation = $idx == 0 ? 'parent' : 'grandparent';
    my $great = $idx > 1 ? 'great-' x ( $idx - 1 ) : q{};
    my $ordinal = color 'yellow', qq{$great$relation};
    my $member  = color 'green',  $tree[$idx];
    my $separator =
      $idx == 0 ? q{} : $length <= 2 || $idx == $length - 2 ? ' and ' : ', ';
    $results = $results . $separator . "$ordinal = $member";
  }
  return $results;
}

sub assert_root {
  my @tree      = @{ +shift };
  my $last_elem = $tree[-1];

  if ( $last_elem ne '1/1' ) {
    my $beginning = color 'yellow', 'Curious fraction tree rooted at ';
    my $root      = color 'red',    $last_elem;
    my $middle    = color 'yellow', ' and not at ';
    my $end       = color 'green',  '1/1';
    return $beginning . $root . $middle . $end;
  }
  return 0;
}

sub repl {
  my $prompt =
      'Enter a fraction (i.e.: "'
    . color( 'green', '3/5' )
    . '") or type "'
    . color( 'yellow', 'exit' )
    . '" to quit /> ';
  my $continue_prompt =
      'Enter "'
    . color( 'yellow', 'more' )
    . '" to see more details, or enter a fraction (i.e.: "'
    . color( 'green', '3/5' )
    . '") to continue /> ';
  my $current_tree;
  my $generations;
  my $assert_root;

  print $prompt;

  while ( my $line = <> ) {
    chomp $line;

    $line =~ s/ \A \s+ | \s+ \z //gx;

    if ( $line eq 'exit' || $line eq 'quit' || $line eq 'q' ) {
      print color( 'yellow', 'Goodbye.' ), "\n";
      return 0;
    }

    if ( $current_tree && $line eq 'more' ) {
      my @tree  = @{$current_tree};
      my $slice = [ @tree[ 1 .. $#tree ] ];
      print format_results($slice), "\n";

      if ($assert_root) {
        print $assert_root, "\n";
      }

      $current_tree = undef;
      $generations  = undef;
      $assert_root  = undef;

      print $prompt;
      next;
    }

    my $fraction = is_fraction_string $line;

    if ($fraction) {
      if ( $fraction eq '1/1' ) {
        my $message = color( 'green', '1/1' ) . " is root.\n";
        print $message;
        print $prompt;
        next;
      }

      $current_tree = get_curious_tree $fraction;
      $generations  = get_curious_generations $current_tree;
      $assert_root  = assert_root $current_tree;
      print format_results($generations), "\n";
      print $continue_prompt;
      next;
    }

    print "Sorry, I don't understand $line\n";
    print $prompt;
  }
  return 0;
}

sub print_banner {
  my $message   = 'A Curious Fracion Tree';
  my $underline = q{=} x length $message;

  return print color( 'yellow', $message . "\n" . $underline . "\n" );
}

################################################################################
# Main #########################################################################
################################################################################

print_banner();
repl();
