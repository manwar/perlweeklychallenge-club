#! /usr/bin/env raku

subset PosInt of Int where * >= 1;

unit sub MAIN (PosInt $m, PosInt $n, :v(:$verbose));

my $size = $m.chars;
my $upto = 2 ** $size - 1;

say ": Bitmap: { $upto.fmt('%b') }" if $verbose;

my @candidates;

for 1 .. $upto -> $mask
{
  my $bitmap = $mask.fmt('%0' ~ $size ~ 'b');

  my $value  = $m.comb.grep({ state $index = 0; $bitmap.substr($index++,1) > 0 }).join;

  say ": Candidate: $m AND $bitmap -> $value" if $verbose;

  @candidates.push: $value unless $value.chars == $size;
}

my @divisible  = @candidates.grep( * %% $n );

say ": Candidates: { @candidates.join(", ") }" if $verbose;
say ": Divisibles: { @divisible.join(", ") }"  if $verbose;

say @divisible.elems;
