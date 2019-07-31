#! /usr/bin/perl

use strict;
use warnings;

# Write a script that can wrap the given paragraph at a specified
# column using the greedy algorithm.

use Getopt::Std;

my %o=(w => 72);
getopts('w:',\%o);

my $s=$o{w};
my @w;
while (<>) {
  chomp;
  if ($_ eq '') {
    if (@w) {
      print join(' ',@w),"\n";
      @w=();
      $s=$o{w};
    }
    print "\n";
  } else {
    foreach my $w (split ' ',$_) {
      my $lw=length($w);
      if ($lw+1 > $s) {
        print join(' ',@w),"\n";
        @w=($w);
        $s=$o{w}-$lw;
      } else {
        push @w,$w;
        $s-=($lw+1);
      }
    }
  }
}
if (@w) {
  print join(' ',@w),"\n";
}
