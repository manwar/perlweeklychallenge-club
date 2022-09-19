#!/usr/bin/env perl
use strict;
use warnings;

die "No arg(s) provided!" unless
  defined $ARGV[0] && $ARGV[0] =~ /\w+/;

sub first_unique_character{
  my @chars = split '', $_[0];
  my %hash;
  $hash{$_}++ foreach @chars;
  foreach my $i(0..$#chars){
    if($hash{$chars[$i]} == 1){
      return sprintf "%d as '%s' is the first unique character\n", $i, $chars[$i];
    }
  }
}

print first_unique_character($ARGV[0]);
