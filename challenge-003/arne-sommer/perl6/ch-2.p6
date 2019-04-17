#! /usr/bin/env perl6

my $top = -1;

subset Int3 of Int where * >= 3;

#| size is an integer from 3 and upwards.
sub MAIN (Int3 $size)
{
  my @values;
  @values[1][$top +1] = 1;

  for 2 .. $size -> $level
  {    
     for 1 .. $level -> $current
     {
        my $id = $top - $level + $current * 2;
	next if $id < 0;
	
        @values[$level][$id] = (@values[$level -1][abs($id -1)] // 0)
	                     + (@values[$level -1][$id +1]      // 0);
     }
  }

  for 1 .. $size -> $level
  {
     print " " x ($size - $level) * 3;
     my @partial = @values[$level; *].grep( *.defined );

     my @row = @partial.reverse;

     @partial.pop if @values[$level;0].defined;

     @row.append(@partial);

     say @row.map( *.fmt('%3d') ).join("   ");
  }
}

