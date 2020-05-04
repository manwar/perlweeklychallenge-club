#! /usr/bin/perl

use strict;
use warnings;
use utf8;

my $k=3;
my @list=(1,4,3,2,5,2);

if (@ARGV) {
  $k=pop @ARGV;
  @list=@ARGV;
}

my @m;
foreach (0..$#list) {
  if ($list[$_] < $k) {
    push @m,1;
  } else {
    push @m,2;
  }
}

my @out;
foreach my $mode (1,2) {
  push @out,map {$list[$_]} grep {$m[$_]==$mode} 0..$#m;
}

binmode STDOUT,':encoding(UTF-8)';
print join(' → ',@out),"\n";
