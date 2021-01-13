#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use List::Util qw/sum0/;

sub solve {
  my ($C, $S) = @_;
  if ($S == 0) {
    return ([]);
  }
  my @solutions;
  for my $coin (@$C) {
    if ($S - $coin >= 0) {
      push @solutions,  grep { sum0(@$_) == $S }
        map { [ $coin, @$_ ] } solve($C, $S - $coin);
    }
  }
  return @solutions;
}

sub task1 :prototype(\@$) {
  my ($C, $S) = @_;
  my @solutions = solve $C, $S;
  # Get rid of duplicates. There's gotta be a cleaner way than this...
  my %canonical;
  local $" = ", ";
  for my $solution (@solutions) {
    my @sorted = sort { $a <=> $b } @$solution;
    $canonical{"@sorted"}++;
  }
  @solutions = sort keys %canonical;
  my $num = @solutions;
  say "There are $num possible ways to make sum $S";
  my $id = "a";
  for my $solution (@solutions) {
    say "$id) ($solution)";
    $id++;
  }
}

my @C = (1, 2, 4);
my $S = 6;
task1 @C, $S;
