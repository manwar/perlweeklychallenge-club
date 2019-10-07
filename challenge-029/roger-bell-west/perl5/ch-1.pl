#! /usr/bin/perl

use strict;
use warnings;

# Write a script to demonstrate brace expansion. For example, script would take command line argument Perl {Daily,Weekly,Monthly,Yearly} Challenge and should expand it and print like below:
#
#   Perl Daily Challenge
#
#   Perl Weekly Challenge
#
#   Perl Monthly Challenge

foreach my $text (@ARGV) {
  my %r;
  my @e=split /(\{.*?\})/,$text;
  foreach my $i (0..$#e) {
    if ($e[$i] =~ /^\{(.*)\}$/) {
      my @b=split ',',$1;
      $r{$i}=$#b;
      $e[$i]=\@b;
    }
  }
  my %a=map {$_ => 0} keys %r;
 OUTER:
  while (1) {
    my @out;
    foreach my $k (0..$#e) {
      if (exists $r{$k}) {
        push @out,$e[$k][$a{$k}];
      } else {
        push @out,$e[$k];
      }
    }
    print join('',@out),"\n";
    my @kl=sort keys %a;
    unless (@kl) {
      last;
    }
    my $i=0;
    while (1) {
      $a{$kl[$i]}++;
      if ($a{$kl[$i]} > $r{$kl[$i]}) {
        $a{$kl[$i]}=0;
        $i++;
        if ($i > $#kl) {
          last OUTER;
        }
      } else {
        last;
      }
    }
  }
}
