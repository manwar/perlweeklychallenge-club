#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings "experimental::signatures";

use Getopt::Long;
use Algorithm::Combinatorics 'permutations';

my $short = 0;
my $all   = 0;

GetOptions("short"    => \$short,
           "all"      => \$all);

$all = 1 if $short;

my @values = @ARGV;

for my $perm (permutations(\@values))
{
  if (check_values(@$perm))
  {
    my ($a, $b, $c, $d, $e, $f, $g) = @$perm;
    if ($short)
    {
      say "a=$a, b=$b, c=$c, d=$d, e=$e, f=$f, g=$g";
    }
    else
    {
      say "a = $a";
      say "b = $b";
      say "c = $c";
      say "d = $d";
      say "e = $e";
      say "f = $f";
      say "g = $g";
      say "";
      say "Box 1: a + b = $a + $b = "          . ($a + $b);
      say "Box 2: b + c + d = $b + $c + $d = " . ($b + $c + $d);
      say "Box 3: d + e + f = $d + $e + $f = " . ($d + $e + $f);
      say "Box 4: f + g = $f + $g = "          . ($f + $g);
      say "" if $all;
    }

    last unless $all;
  }
}

sub check_values (@values)
{

  my ($a, $b, $c, $d, $e, $f, $g) = @values;
  my $box1 = $a + $b;
  my $box2 = $b + $c + $d;
  my $box3 = $d + $e + $f;
  my $box4 = $f + $g;
  return ($box1 == $box2 && $box3 == $box4 && $box1 == $box3)
}
