#! /usr/bin/env raku

unit sub MAIN ($codes, $names, $status, :v(:$verbose));

my @codes  = $codes.words;
my @names  = $names.words;
my @status = $status.words;
my @result;

die "Uneven length" unless @codes.elems == @names.elems == @status.elems;

for ^@codes -> $i
{
  my $ok-code   = so @codes[$i] ~~ /^<[a..z A..Z 0..9 _]>+$/;
  my $ok-name   = so @names[$i] eq any <electronics grocery pharmacy restaurant>;
  my $ok-status = so @status[$i] eq 'true';
  my $ok        = so $ok-code && $ok-name && $ok-status;

  say ": Index:$i Code:$ok-code Name:$ok-name Status:$ok-status -> $ok" if $verbose;

  @result.push: $ok;
}

say "({ @result.join(", ") })";
