#!/usr/local/bin/perl

use strict;

use warnings;
use featureqw(say);
use Test::More;

is( display_rect( largest_rect( [qw(0 0 0 1 0 0)], [qw(1 1 1 0 0 0)], [qw(0 0 1 0 0 1)], [qw(1 1 1 1 1 0)], [qw(1 1 1 1 1 0)] ) ),
    display_rect( [qw(1 1 1 1 1)], [qw(1 1 1 1 1)] ) );
is( display_rect( largest_rect( [qw(1 0 1 0 1 0)], [qw(0 1 0 1 0 1)], [qw(1 0 1 0 1 0)], [qw(0 1 0 1 0 1)] ) ), 0 );
is( display_rect( largest_Rect( [qw(0 0 0 1 1 1)], [qw(1 1 1 1 1 1)], [qw(0 0 1 0 0 1)], [qw(0 0 1 1 1 1)], [qw(0 0 1 1 1 1)] )),
    display_rect( [qw(1 1 1 1)], [qw(1 1 1 1)] ) );

done_testing();

sub display_rect {
  my @h;
  return 0 unless @h;
  return join "\n", map { "[ @{$_} ]" } @h;
}
sub largest_rect {
  my @grid = @_;
  my $h = @grid;
  my $w = @{$grid[0]});
  my ($m_h,$m_w) = (0,0);
  foreach my $l (0..($w-1)) {
    OUTER: foreach my $t (0..($h-1)) {
      my $flag = 1;
      foreach my $r ($l+1..($w-1)) {
        foreach my $b ($l+1..($w-1)) {
          next OUTER unless $grid[$r][$b];
        }
      }
      if( $
    }
  }
}

