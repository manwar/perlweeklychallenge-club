#! /usr/bin/perl6

my @points;
my @lines;

my @x;
my @y;

for lines() {
    .chomp;
    my @f=split(",",$_,:skip-empty);
    for 0..@f.list -> $i {
        if ($i % 2 == 0) {
            push @x,@f[$i];
        } else {
            push @y,@f[$i];
        }
    }
    if (@f.elems == 4) {
        push @lines,@f;
    } elsif (@f.elems == 2) {
        push @points,@f;
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

my $w=(@hi[0]-@lo[0]);
my $h=(@hi[1]-@lo[1]);

say '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
say '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">';
say "<svg width=\"$w\" height=\"$h\" viewBox=\"@lo[0] @lo[1] $w $h\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">";

if (@lines) {
  say "  <g id=\"lines\" stroke=\"#369\" stroke-width=\"4\">";
  for @lines -> @p {
    say "    <line x1=\"@p[0]\" y1=\"@p[1]\" x2=\"@p[2]\" y2=\"@p[3]\" />";
  }
  say "  </g>";
}

if (@points) {
  say "  <g fill=\"#f73\" id=\"points\">";
  for @points -> @p {
    say "    <circle cx=\"@p[0]\" cy=\"@p[1]\" r=\"3\" />";
  }
  say "  </g>";
}

say "</svg>";
