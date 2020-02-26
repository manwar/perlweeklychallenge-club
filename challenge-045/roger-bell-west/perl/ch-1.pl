#! /usr/bin/perl

use strict;
use warnings;

use Getopt::Std;

my %o=(n => 8);

getopts('n:',\%o);

my $in='';
while (<>) {
  s/\s+//g;
  $in.=$_;
}

my $l=length($in)-1;
my @out;
foreach my $c (0..$o{n}-1) {
  my $out;
  for (my $k=$c;$k<=$l;$k+=$o{n}) {
    $out.=substr($in,$k,1);
  }
  push @out,$out;
}

print join(' ',@out),"\n";
