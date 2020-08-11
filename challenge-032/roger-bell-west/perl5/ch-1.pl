#! /usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Text::CSV_XS;

my %o;
getopts('c',\%o);

my %s;
while (<>) {
  chomp;
  $s{$_}++;
}

my $csv = Text::CSV_XS->new;

foreach my $k (sort {$s{$b} <=> $s{$a} ||
                       $a cmp $b} keys %s) {
  if ($o{c}) {
    $csv->say(*STDOUT,[$k,$s{$k}]);
  } else {
  print "$k $s{$k}\n";
  }
}
