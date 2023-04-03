#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 0 && @list.all ~~ Int, :v($verbose));

my $index = 0;

loop
{
  last unless @list.elems;
  last if $index == @list.end;

  my $left  = @list[$index];
  my $right = @list[$index +1];

  print ": { @list.join(",") } index $index " if $verbose;

  if $left >= 0 && $right < 0
  {
    if $left > $right.abs 
    {
      @list.splice($index+1,1);
      say "> Remove $right at index {$index+1} -> { @list.join(",") }" if $verbose;
    }
    elsif $left < $right.abs
    {
      @list.splice($index,1);
      say "< Remove $left at index $index -> { @list.join(",") }" if $verbose;
      $index-- unless $index == 0;
    }
    else
    {
      @list.splice($index,2);
      say " = Remove $left and $right at index $index and { $index +1 } -> { @list.join(",") }" if $verbose; 
      $index-- unless $index == 0;
    }
  }
  else
  {  
    say "" if $verbose;
    $index++;
  }
}

say "({ @list.join(",") })";
