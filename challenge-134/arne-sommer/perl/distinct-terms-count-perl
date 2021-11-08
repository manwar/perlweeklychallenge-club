#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util 'uniq' ;
my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $m = $ARGV[0] // 0;
my $n = $ARGV[1] // 0;

die "Postive integer only" unless $m =~ /^[1-9]\d*$/;
die "Postive integer only" unless $n =~ /^[1-9]\d*$/;

my @values;

for my $row (1 .. $m)
{
  my @row = map { $_ * $row } 1.. $n;
  push(@values, \@row);
}

my $width   = length($m * $n);
my $r_width = length($m);

say ":Max width number: $width"   if $verbose;
say ":Max width row ID: $r_width" if $verbose;

say sprintf('%' . ( $width - 1 ) . "s", "x"),
    " |",
    join(" ", map { sprintf('%' . $width . "d", $_) } (1..$n));

say "-" x $r_width, "-+", "-" x ($n * ($width +1) );

my $i = 0;

my @all;

for my $row (@values)
{
  my @row = @$row;
  push(@all, @row);
  say sprintf('%' . $r_width . "d", ++$i) ,
      " |",
      join(" ", map { sprintf('%' . $width . "d", $_) } @row);
}

my @distinct = sort { $a <=> $b } uniq(@all);

say "";
say "Distinct Terms: ", join(", ", @distinct);
say "Count: " . @distinct;
