#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               :v(:$verbose));

my @freq;
my $curr = @ints[0];
my $freq = 1;

for @ints[1 .. Inf] -> $int
{
  if $int == $curr
  {
    $freq++;
  }
  else
  {
    @freq.push: $freq;
    $curr = $int;
    $freq = 1;
  }
}

@freq.push: $freq;

my $min = @freq.min;

if $verbose
{
  say ": Frequency: { @freq.join(", ") }";
  say ": Group size (min freq): $min";
}

for 2 .. $min -> $i
{
  next unless $i.is-prime;

  if all(@freq) %% $i
  {
    if $verbose
    {
      say ": Group size (prime): $i";
      say ": Grouped: { @ints>>.Int.rotor($i).raku }";
    }
    say 'true';
    exit;
  }
}

say 'false';