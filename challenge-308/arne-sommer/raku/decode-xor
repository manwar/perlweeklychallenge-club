#! /usr/bin/env raku

unit sub MAIN (*@encoded where @encoded.elems > 0 && all(@encoded) ~~ Int,
               Int :i(:$initial),
               :v(:$verbose));

my @output = $initial;
my $source = $initial;

for @encoded -> $current
{
  my $original = $current +^ $source;
  say ": ($source xor $original = $current)" if $verbose;

  $source = $original;
  @output.push: $original;
}

say "({ @output.join(", ") })";
