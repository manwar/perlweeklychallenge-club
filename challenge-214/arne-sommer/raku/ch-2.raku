#! /usr/bin/env raku

unit sub MAIN (*@numbers where @numbers.elems > 0 && all(@numbers) ~~ Numeric, :v(:$verbose));

my $score = 0;
my %freq;
my $cheat = False;

while (@numbers.elems)
{
  $cheat
    ?? ( $cheat = False )
    !! ( %freq  = @numbers.Bag );

  my $size = @numbers.elems;

  for %freq.keys.sort -> $value
  {
    my $freq  = %freq{$value};
    my $index = @numbers.first($value, :k);

    if all(@numbers[$index .. $index + $freq -1]) eq $value
    {
      sink @numbers.splice($index, $freq);
      $score += $freq * $freq;
      say ": Removed the value $value ($freq items, at index: $index .. { $index + $freq -1}). New score: $score" if $verbose;
    }
  }

  if @numbers.elems == $size
  {
    my $val = %freq.keys.sort({ %freq{$_} }).first;
    %freq{$val}--;
    $cheat = True;
    say ": Enable cheat mode on value $val" if $verbose;
  }
}

say "ERROR: Unable to reduce @numbers[]" if @numbers.elems;

say $score;
