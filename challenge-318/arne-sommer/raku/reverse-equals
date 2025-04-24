#! /usr/bin/env raku

subset NUMWORD where * ~~ /^<[0..9 \s]>+$/;

unit sub MAIN (NUMWORD $source,
               NUMWORD $target,
               :v(:$verbose));

my @source = $source.words;
my @target = $target.words;

die "Not the same elements" unless @source.sort eqv @target.sort;

if @source eqv @target
{
  say 'true';
  exit;
}

my $end = @target.end;

for ^$end -> $i
{
  for $i + 1 .. $end -> $j
  {
    my @copy = @source.clone;
    @copy[$i .. $j] = @copy[$i .. $j].reverse;

    say ": ({ @source.join(",") }) Reverse $i..$j -> ({ @copy.join(",") })" if $verbose;

    if @copy eqv @target
    {
      say 'true';
      exit;
    }
  }
}

say 'false';