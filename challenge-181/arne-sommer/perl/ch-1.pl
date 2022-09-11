#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use File::Slurp;

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my $file      = shift(@ARGV) || "paragraph.txt";
my $content   = read_file($file);
my @sentences = split(/\./, $content);

say ":sentences: " . join("\n", map { '"' . $_ . '"' } @sentences) if $verbose;

my @result;

for my $sentence (@sentences)
{
  my @words = split(/\s+/, $sentence);
  push(@result, join(" ", sort { lc $a cmp lc $b } @words));
}

say join(". ", @result);
