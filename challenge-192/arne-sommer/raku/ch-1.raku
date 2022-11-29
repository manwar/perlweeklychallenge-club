#! /usr/bin/env raku

unit sub MAIN (Int $n where * > 0, :v(:$verbose));

my $binary  = $n.base(2);
my $flip    = $binary.comb.map({ $_ eq '1' ?? '0' !! '1' }).join;
my $decimal = $flip.parse-base(2);

if $verbose
{
  say ":Binary: $binary";
  say ":Flip:   $flip";
}

say $decimal;
