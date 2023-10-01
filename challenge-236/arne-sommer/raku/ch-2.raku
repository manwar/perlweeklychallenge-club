#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems == @ints.unique.elems, :i(:$index), :v(:$verbose));

die "Use the index values (0..{@ints.end}) only" if $index && @ints.min != 0 && @ints.max != @ints.end;

say ":Index:Value: ", (^@ints).map({ $_ ~ ":" ~ @ints[$_] }).join(", ") if $verbose;

my $loop-count = 0;
my %seen;

FORLOOP:
for ^@ints.elems -> $start
{
  next if %seen{$start}++;

  my $pos  = $start;
  my @loop = "[$start]";

  loop
  {
    unless 0 <= $pos <= @ints.end
    {
      say ":Non-Loop: { @loop.join(" ") }" if $verbose;
      next FORLOOP;
    }

    $pos = @ints[$pos];
    @loop.push: $pos;
    %seen{$pos}++;
    last if $pos == $start;
  }

  $loop-count++;
  say ":Loop { @loop.join(" ") }" if $verbose;
}

say $loop-count;
