#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

done_testing();

match_teams( map { $_*10 } 1..10 );
match_teams( qw(10 -15 20 30 -25 0 5 40 -5) );

sub match_teams {
  my @n = @_;
  my $diff = shift @n;
  my $best = [];
  separate( \@n, 1 + int(@n/2), [$diff], [], $diff, $best );
  say "Team 1: [@{$best->[0]}]; Team 2[@{$best->[1]}]; difference $best->[2]";
  sub separate {
    my($nums,$maxsize,$team1,$team2,$diff,$be) = @_;
    if(@{$nums}==0) {
      unless( defined $be->[0] && abs $diff>=$be->[2] ) {
        $be->[0] = $team1;
        $be->[1] = $team2;
        $be->[2] = abs $diff;
      }
      return;
    }
    my $next = shift @{$nums};
    separate( [@{$nums}], $maxsize, [@{$team1},$next], $team2, $diff+$next, $be ) if @{$team1} < $maxsize;
    separate( [@{$nums}], $maxsize, $team1, [@{$team2},$next], $diff-$next, $be ) if @{$team2} < $maxsize;
  }
}

