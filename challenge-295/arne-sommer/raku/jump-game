#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ UInt,
              :v(:$verbose));

my $target = @ints.end;
my @queue  = ( { at => 0, jumps => 0 }, );

while @queue.elems
{
  my $current = @queue.shift;
  my $steps   = @ints[$current<at>];

  for 1 .. $steps -> $step
  {
    say ": At: $current<at> Steps: $step (of 1..$steps) Jumps: $current<jumps> " if $verbose;

    if $current<at> + $step == $target
    {
      say ": At: $target (the target) Jumps: { $current<jumps> +1 }" if $verbose;
      say $current<jumps> + 1;
      exit;
    }

    @queue.push( { at => $current<at> + $step, jumps => $current<jumps> +1 });
  }
}

say -1;
