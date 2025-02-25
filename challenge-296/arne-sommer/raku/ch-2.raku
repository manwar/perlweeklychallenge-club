#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (*@ints where @ints.elems >= 4 && all(@ints) ~~ PosInt,
               :v(:$verbose));

unless @ints.sum %% 4
{
  say ": Unable to get 4 equally long edges" if $verbose;
  say 'false';
  exit;
}

my $target = @ints.sum / 4;

say ": The edge sizes: $target" if $verbose;

if any(@ints) > $target
{
  say ": One of the sticks is too long" if $verbose;
  say 'false';
  exit;
}

my @square = (0,0,0,0);
my @labels = <Top Bottom Left Right>;
my $i = 0;

STICK:
for @ints -> $stick
{
  $i++;

  say ": Working on stick #$i with length $stick. Square: [{ @square.join(",") }]" if $verbose;

  for 0 .. 3 -> $index
  {
    say ":   Checking @labels[$index]" if $verbose;
    next unless @square[$index] + $stick <= $target;
    
    @square[$index] += $stick;
    say ":   Added stick #$i to @labels[$index] -> length: @square[$index]" if $verbose;
    next STICK;
    
  }

  say ":   Unable to use this stick" if $verbose;
  say 'false';
  exit;
}

say ": Square: [{ @square.join(",") }]" if $verbose;

say [==] @square ?? 'true' !! 'false';
