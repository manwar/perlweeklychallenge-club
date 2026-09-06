#! /usr/bin/env raku

unit sub MAIN (*@nums is copy where @nums.elems > 0 && all(@nums) ~~ Int,
               :v(:$verbose));

my @all = gather
{
  my $direction;
  my @path = @nums.shift.Int,;

  for @nums -> $curr
  {
    my $new-direction = ( $curr <=> @path[*-1] ).Int;

    print ": ({ @path.join(",") }) + $curr d:$new-direction o:{ $direction // "-"}" if $verbose;
    
    if @path.elems == 1
    {
      if $new-direction == 0
      {
        @path      = $curr.Int,;
	$direction = Nil;
	
	say " equal" if $verbose;
      }
      else
      {
        @path.push($curr.Int);
        $direction = $new-direction;

        say " init" if $verbose;
      }
    }
    elsif $new-direction == 0
    {
      take @path.join(" ");

      @path      = $curr.Int,;
      $direction = Nil;

      say " break=" if $verbose;
    }
    elsif $new-direction == $direction
    {
      take @path.join(" ");

      @path      = @path[*-1], $curr.Int;
      $direction = $new-direction;
      
      say " break~" if $verbose;
    }
    else
    {
      @path.push($curr.Int);
      $direction = $new-direction;
      
      say " " ~ ($new-direction == 1 ?? "up" !! "down") if $verbose;
    }
  }

  take @path.join(" ") if @path.elems;
}

if $verbose
{
  say ": subarrays: " ~ @all.raku;
  say ": sizes: " ~ @all>>.words>>.elems.raku;
};

say @all>>.words>>.elems.max;
