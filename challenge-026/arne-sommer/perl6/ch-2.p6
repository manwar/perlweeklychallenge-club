#! /usr/bin/env perl6

unit sub MAIN (*@angles);

my \n    = @angles.elems;
my @rad  = @angles.map(* * pi / 180);
my \s    = @rad.map(*.sin).sum / n;
my \c    = @rad.map(*.cos).sum / n;
my $mean = atan2( s / c ) * 180 / pi;

if    c < 0 { $mean += 180; }
elsif s < 0 { $mean += 360; }

say "mean: $mean";

