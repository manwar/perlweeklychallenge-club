#! /usr/bin/env raku

subset BOARDPOS where * ~~ /^<[a..h]><[1..8]>$/;

unit sub MAIN (BOARDPOS $coordinate, :v(:$verbose));

my ($col, $row) = $coordinate.comb;

say ": Row $row, Col $col" if $verbose;

say $col eq any(<a c e g>)
  ?? $row %% 2
  !! $row !%% 2;
