#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(min max);

my @points;
my @lines;

my @x;
my @y;

while (<>) {
  chomp;
  my @f=split /,/,$_;
  foreach my $i (0..$#f) {
    if ($i % 2 == 0) {
      push @x,$f[$i];
    } else {
      push @y,$f[$i];
    }
  }
  if (scalar @f == 4) {
    push @lines,\@f;
  } elsif (scalar @f == 2) {
    push @points,\@f;
  } else {
    die "Invalid input $_\n";
  }
}

my $mnx=min(@x);
my $mxx=max(@x);

my $mny=min(@y);
my $mxy=max(@y);

my @lo=(
  $mnx-($mxx-$mnx)/10,
  $mny-($mxy-$mny)/10,
    );
my @hi=(
  $mxx+($mxx-$mnx)/10,
  $mxy+($mxy-$mny)/10,
    );

my $w=($hi[0]-$lo[0]);
my $h=($hi[1]-$lo[1]);

print <<EOF;
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg width="$w" height="$h" viewBox=\"$lo[0] $lo[1] $w $h\" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
EOF

if (@lines) {
  print "  <g id=\"lines\" stroke=\"#369\" stroke-width=\"4\">\n";
  foreach my $p (@lines) {
    print "    <line x1=\"$p->[0]\" y1=\"$p->[1]\" x2=\"$p->[2]\" y2=\"$p->[3]\" />\n";
  }
  print "  </g>\n";
}

if (@points) {
  print "  <g fill=\"#f73\" id=\"points\">\n";
  foreach my $p (@points) {
    print "    <circle cx=\"$p->[0]\" cy=\"$p->[1]\" r=\"3\" />\n";
  }
  print "  </g>\n";
}

print "</svg>\n";
