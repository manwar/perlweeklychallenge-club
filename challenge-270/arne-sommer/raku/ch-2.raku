#! /usr/bin/env raku

unit sub MAIN (UInt :$x where $x > 0 = 2,
               UInt :$y where $y > 0 = 3,
	       *@ints is copy,
               :v(:$verbose));

die "Non-negative integers only" unless all(@ints) ~~ UInt;

my $target = @ints.max;
my $cost   = 0;

say ": Target: $target" if $verbose;

if $x + $x > $y
{
  loop
  { 
    last if all(@ints) == $target;

    last if @ints.grep( * eq $target ).elems == @ints.elems -1;

    say ": Ints: @ints[]" if $verbose;

    my @pairs = @ints.pairs.sort({ $^a.value <=> $^b.value });

    my $first_idx  = @pairs[0].key;
    my $second_idx = @pairs[1].key;

    say ": Level 2: Add cost: $y for bringing \@ints[$first_idx] from { @ints[$first_idx] } to { @ints[$first_idx] +1 } and \@ints[$second_idx] from { @ints[$second_idx] } to { @ints[$second_idx] +1 }" if $verbose;

    $cost += $y;

    @ints[$first_idx]++;
    @ints[$second_idx]++;
  }
}

say ": Ints after level 2: @ints[]" if $verbose;

for ^@ints.elems -> $index
{
  my $delta = $target - @ints[$index];

  next unless $delta;

  $cost += $delta * $x;

  say ": Level 1: Add cost: { $delta * $x } ($delta times $x) for bringing \@ints[$index] from { $target - $delta } to $target" if $verbose;
}

say $cost;