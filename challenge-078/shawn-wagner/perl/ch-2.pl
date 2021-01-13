#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

sub rotate_left :prototype(\@$) {
  my ($A, $idx) = @_;
  my @A = @$A;
  my @left = splice @A, 0, $idx;
  push @A, @left;
  return \@A;
}

sub rotate_left_multi :prototype(\@\@) {
  my ($A, $B) = @_;
  for my $idx (@$B) {
    my $rotated = rotate_left @$A, $idx;
    say "[@$rotated]";
  }
  say "---";
}


my @A = (10, 20, 30, 40, 50);
my @B = (3, 4);
rotate_left_multi @A, @B;

@A = (7, 4, 2, 6, 3);
@B = (1, 3, 4);
rotate_left_multi @A, @B;
