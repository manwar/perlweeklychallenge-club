#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw[max];

# Print histogram
sub print_histogram {
  my @lines = @_;
  my $len = scalar @lines;
  my $max = scalar @{$lines[0]};
  my @nums = ();

  print "\n";

  for (my $i = $max - 1; $i >= 0; $i--) {
    print ($i+1);
    print " | ";
    my $counter = 0;

    foreach my $l (@lines) {
      my @line = @{$l};
      print $line[$i]." ";

      $counter++ if($line[$i] eq "#");
    }

    push @nums, $counter;
    print "\n";
  }

  print "- | ";
  print "- " for (@lines);
  print "\n";

  print "- | ";
  for my $l (@lines) {
    my $count = grep { $_ eq '#' } @{$l};
    print $count." ";
  };

  print "\n\n";
}

# Handle histogram
sub histogram {
  my $out = shift @_;
  my $len = scalar @_;

  return 0 if($len == 0);

  my $max = max(@_) + 1;
  my @bonus = ();
  my @vals = (0) x $max;
  my $area = 0;

  foreach my $val (@_) {
    my @line = ();

    if($val != 0) {
      for(my $i = 1; $i <= $val; $i++) {
        $vals[$i] += $i;
        $area = max($vals[$i], $area);
        push @line, '#';
      }

      for(my $i = $val + 1; $i < $max; $i++) {
        $vals[$i] = 0;
        push @line, ' ';
      }
    } else {
      @vals = (0) x $max;
    }

    push @bonus, \@line;
  }

  if($out) {
    print_histogram(@bonus);
  }

  return $area;
}

# Flag for printing
my $out = 1;

# Input/Output
if(scalar @ARGV > 0) {
  print "Output: ".histogram($out , @ARGV)."\n";
} else {
  my @arr1 = (2, 1, 4, 5, 3, 7);
  print "Output: ".histogram($out , @arr1)."\n";

  my @arr2 = (3, 2, 3, 5, 7, 5);
  print "Output: ".histogram($out, @arr2)."\n";
}