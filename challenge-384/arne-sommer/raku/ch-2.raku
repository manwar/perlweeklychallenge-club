#! /usr/bin/env raku

subset BINARY where /^ <[01]>+ $ /;

unit sub MAIN (BINARY $binary, :v(:$verbose));

my @ok;

for 0 .. $binary.chars - 2 -> $i
{
  for $i + 1 .. $binary.chars - 1 -> $j
  {
    my $candidate = $binary.substr($i, $j - $i +1);

    next unless $candidate.chars %% 2;
    next unless $candidate.comb.sum == $candidate.chars / 2;
    next unless $candidate ~~ /^ (0+ 1+ | 1+ 0+) $/;

    say ":$binary" ~ "[$i .. $j] -> $candidate" if $verbose;

    @ok.push: $candidate;
  }
}

say "({ @ok.unique.map( '"' ~ * ~ '"' ).join(", ") })";