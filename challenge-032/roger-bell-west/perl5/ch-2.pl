#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);

my $data = { apple => 3, cherry => 2, banana => 1 };
generate_bar_graph($data);

sub generate_bar_graph {
  my $data=shift;
  my $width=shift || $ENV{COLUMNS} || 80;
  my $labelordering=shift or 0;
  my @k=keys %{$data};
  if ($labelordering) {
    @k=sort @k;
  } else {
    @k=sort {$data->{$b} <=> $data->{$a}} @k;
  }
  my $kl=max(map {length($_)} @k);
  my $bw=$width-$kl-3;
  my $scale=$bw/max(values %{$data});
  my $format='%-'.$kl.'s | %-'.$bw."s\n";
  foreach my $k (@k) {
    printf($format,$k,'#' x ($scale*$data->{$k}));
  }
}
