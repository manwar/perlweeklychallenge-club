#! /usr/bin/env raku

unit sub MAIN (Str $S where $S.chars > 0,
               Str $T where $T.chars > 0,
	       :v(:$verbose));

my $S-length = $S.chars;
my $T-length = $T.chars;
my $binary   = '1' x $S-length;
my $max      = $binary.parse-base(2);
my $matches  = 0;

for 1 .. $max -> $current
{
  my $mask = $current.fmt('%0' ~ $S-length ~ 'b');

  if $mask.comb.sum != $T-length
  {
    say ":   Skipped binary mask '{ $mask }' - wrong number of 1s" if $verbose;
    next;
  }

  my $candidate = (^$S-length).map({ $mask.substr($_, 1) eq '1' ?? $S.substr($_,1) !! '' }).join;

  if $candidate eq $T
  {
    $matches++;
    say ": + Match found with binary mask '{ $mask }'." if $verbose;
  }
  else
  {
    say ":   Considering binary mask '{ $mask}' - no match" if $verbose;
  }
}

say $matches;


