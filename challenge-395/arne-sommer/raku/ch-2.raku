#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0
                  && all(@words) ~~ /^ <[a..zA..Z]>+ $/
                  && ( [==] @words>>.chars ),
                :v(:$verbose));

my $n = @words[0].chars;

my @rows;

sub solve(Int $i)
{
  return True if $i == $n;

  my $prefix = @rows.map(*.substr($i, 1)).join;

  for @words -> $w
  {
    next if $w ∈ @rows;
    next unless $w.starts-with($prefix);

    @rows.push: $w;

    return True if solve($i + 1);

    @rows.pop;
  }

  return False;
}

my @result = solve(0) ?? @rows !! ();

if $verbose
{
  for @result -> $w
  {
    say ": " ~ $w.comb.join(" ");
  }
}

say "({ @result.map( '"' ~ * ~ '"' ).join(", ") })";