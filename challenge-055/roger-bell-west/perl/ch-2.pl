#! /usr/bin/perl

use strict;
use warnings;

my @input=@ARGV;
unless (@input) {
  @input=(1..4);
}
my %candidates;
map {$candidates{$_}++} @input;

@input=sort @input;

my @tree=map {[$_]} @input;

while (1) {
  if ($#{$tree[0]} == $#input) {
    last;
  }
  my $branch=shift @tree;
  my %cc=%candidates;;
  map {$cc{$_}--} @{$branch};
  foreach my $ca (keys %cc) {
    if ($cc{$ca}<1) {
      delete $cc{$ca};
    }
  }
  my @cc;
  my $dir=(scalar @{$branch})%2; # 1 = go down, 2 = go up
  if ($dir==1) {
    @cc=grep {$_ <= $branch->[-1]} keys %cc;
  } else {
    @cc=grep {$_ >= $branch->[-1]} keys %cc;
  }
  foreach my $c (sort @cc) {
    push @tree,[@{$branch},$c];
  }
}

my $l='';
foreach my $a (@tree) {
  my $t=join(', ',@{$a});
  if ($t ne $l) {
    print "[$t]\n";
    $l=$t;
  }
}
