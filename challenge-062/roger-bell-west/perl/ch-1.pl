#! /usr/bin/perl

use strict;
use warnings;

use Getopt::Std;

my %o;
getopts('u',\%o);

my %l;

while (<>) {
  chomp;
  my @e=split /@/,$_;
  my $k=lc($e[1]).'@'.$e[0];
  if ($o{u}) {
    delete $l{$k};
  }
  push @{$l{$k}},$_;
}

foreach my $k (sort keys %l) {
  print map {"$_\n"} @{$l{$k}};
}
