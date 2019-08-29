#! /usr/bin/perl

use strict;
use warnings;

use Getopt::Std;

my %o=('d' => 2);
getopts('d:',\%o);
my @seq=@ARGV;

foreach (1..$o{d}) {
  my @o=map {$seq[$_+1]-$seq[$_]} (0..$#seq-1);
  @seq=@o;
}

print join(' ',@seq),"\n";
