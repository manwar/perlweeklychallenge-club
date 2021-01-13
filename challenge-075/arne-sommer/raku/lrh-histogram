#! /usr/bin/env raku

subset NonNegativeInt of Int where * >= 0;

unit sub MAIN (*@A where @A.elems >= 1 && all(@A) ~~ NonNegativeInt, :v(:$verbose), :h(:$histogram));

my $end = @A.end;

my @solutions;
my $max = -1;

for 0 .. $end -> $from
{
  for $from .. $end -> $to
  {
    my $height = min(@A[$from .. $to]);
    my $width  = $to - $from +1;
    my $size   = $height * $width;
    say ": \@A[$from .. $to] -> ({ @A[$from .. $to] }) w:$width h:$height s:$size" if $verbose;

    if $size >= $max
    {
      if $size > $max
      {
        @solutions = ();
        $max = $size;
	say ": New max: $max" if $verbose;
      }
      @solutions.push: @A[$from .. $to].join(", ");
    }
  }
}

if $verbose
{
  say ": columns: $_" for @solutions;
}

say $max;

if $histogram
{
  say '';
  my $height = @A.max;
  my $width  = $height.chars;

  for $height ... 1 -> $row
  {
    print "{ $row.fmt("%{$width}d") } ";
    for 0 .. $end -> $index
    {
      print @A[$index] >= $row
        ?? ('#' x $width ~ " ")
	!! ' ' x $width +1;
    }
    say '';
  }

  say "-" x 6 + $width * ($end +2);
  
  print ' ' x $width +1;
  
  for 0 .. $end -> $index
  {
    print @A[$index].fmt("%{$width}d") ~ " ";
  }
  say '';
}
