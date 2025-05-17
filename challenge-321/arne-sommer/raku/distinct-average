#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1
                  && @ints.elems %% 2
                  && all(@ints) ~~ Int,
               :v(:$verbose));

my @sorted = @ints.sort;
my @avg;

while @sorted
{
  my $low  = @sorted.shift;
  my $high = @sorted.pop;
  my $avg  = ($low + $high) / 2;

  @avg.push: $avg;

  say ": Low:$low, High:$high, Avg: $avg, Todo: @sorted[]" if $verbose;
}

say ": Avg values:{ @avg.join(",") }" if $verbose;

say @avg.unique.elems;