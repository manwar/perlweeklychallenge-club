#!/usr/bin/perl

use strict;
use warnings;

sub get_word {
  my $build = $_[0];
  my $val = $_[1];
  my %dict = %{$_[2]};
  my @res = ();

  if (grep(/^$build$/, @{$dict{$val}})) {
    my $index = 0;
    $index++ until $dict{$val}[$index] eq $build;
    splice(@{$dict{$val}}, $index, 1);
    push @res, $build;
  }

  return @res;
}

# Search grid
sub search_grid {
  my @grid = @{$_[0]};
  my %dict = %{$_[1]};
  my %revs = %{$_[2]};
  my $gridX = scalar @grid;
  my $gridY = scalar @{$grid[0]};
  my @res = ();

  for(my $i = 0; $i < $gridX; $i++) {
    for(my $j = 0; $j < $gridY; $j++) {
      my $val = $grid[$i][$j];
      next if(!$dict{$val});

      #horizontal
      my $build = $val;

      for(my $k = $j + 1; $k < $gridY; $k++) {
        $build .= $grid[$i][$k];
        push @res, get_word($build, $val, \%dict);
        last if (!grep(/$build/, @{$dict{$val}}));
      }

      #vertical
      $build = $val;

      for(my $k = $i + 1; $k < $gridX; $k++) {
        $build .= $grid[$k][$j];
        push @res, get_word($build, $val, \%dict);
        last if (!grep(/$build/, @{$dict{$val}}));
      }

      #diagonal down
      $build = $val;
      my $k1 = $i + 1;
      my $k2 = $j + 1;

      while($k1 < $gridX && $k2 < $gridY) {
        $build .= $grid[$k1][$k2];
        push @res, get_word($build, $val, \%dict);
        last if (!grep(/$build/, @{$dict{$val}}));
        $k1++; $k2++;
      }

      #diagonal up
      $build = $val;
      $k1 = $i + 1;
      $k2 = $j - 1;

      while($k1 < $gridX && $k2 > 0) {
        $build .= $grid[$k1][$k2];
        push @res, get_word($build, $val, \%dict);
        last if (!grep(/$build/, @{$dict{$val}}));
        $k1++; $k2--;
      }
    }
  }

  # Print words
  my %final = map { $revs{$_} ? ($revs{$_} => 1) : ($_ => 1) } @res;
  print $_."\n" for (sort keys %final);
}

# Input/Output
open(my $fh1, "<", "grid.txt") or die "Can't open < grid.txt: $!";
open(my $fh2, "<", "dict.txt") or die "Can't open < dict.txt: $!";

my @grid = ();
while(<$fh1>) {
  chomp;
  my @arr = split(/ /, lc($_));
  push @grid, \@arr;
}

my %dict = ();
my %revs = ();
while(<$fh2>) {
  chomp;
  my $line = $_;
  my $rev = reverse($line);

  my $lineFirst = substr($line, 0, 1);
  $dict{$lineFirst} = () if(!$dict{$lineFirst});
  push @{$dict{$lineFirst}}, lc($line);

  my $revFirst = substr($rev, 0, 1);
  $dict{$revFirst} = () if(!$dict{$revFirst});
  push @{$dict{$revFirst}}, lc($rev);
  $revs{$rev} = $line;
}

search_grid(\@grid, \%dict, \%revs);

close($fh1);
close($fh2);