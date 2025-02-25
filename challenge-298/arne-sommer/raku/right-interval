#! /usr/bin/env raku

unit sub MAIN (Str $intervals = "3 4 | 2 3 | 1 2", :v(:$verbose));

my @intervals = $intervals.split("|")>>.words>>.Numeric;

die "Illegal characters" unless all(@intervals[*;*]) ~~ Int;
die "Interval must have two values only" unless all(@intervals>>.elems) == 2;

say ": Intervals: { @intervals.raku }" if $verbose;

my %start2index;
my $index = 0;

for @intervals -> @interval
{
  die "Interval ends before the start" if @interval[0] > @interval[1];
  die "Interval start @interval[0] already used" if defined %start2index{@interval[0]};
  
  %start2index{@interval[0]} = $index;
  $index++;
}

say ": Start2index: { %start2index.raku }" if $verbose;

my @starts = %start2index.keys.sort;

say ": Start values: { @starts.raku }" if $verbose;

my @output;

for @intervals -> @interval
{
  my $end  = @interval[1];
  my @next = @starts.grep: * >= $end;

  @output.push( @next.elems ?? %start2index{@next.first} !! -1);
}

say "({ @output.join(", ") })";
