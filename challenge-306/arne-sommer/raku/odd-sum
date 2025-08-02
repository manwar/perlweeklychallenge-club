#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && all(@ints) > 0,
               :v(:$verbose));

my $end = @ints.end;
my $sum = 0;

for 0 .. $end -> $start
{
  for $start .. $end -> $stop
  {
    next unless ($stop - $start) %% 2;
    my @slice = @ints[$start .. $stop];
    my $total = @slice.sum;
    $sum += $total;
    
    say ": Slice Indices:$start:$stop Values:({ @slice.join(",") }) Sum:$total Total:$sum" if $verbose;
  }
}

say $sum;
