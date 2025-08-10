#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 2 && all(@list) ~~ /^\d+\,\d+$/,
               :v(:$verbose));

my ($Ax, $Ay) = @list.shift.split(",")>>.Int;
my ($Bx, $By) = @list.shift.split(",")>>.Int;

while @list
{
  my ($Cx, $Cy) = @list.shift.split(",")>>.Int;

  say ": Checking if ($Ax,$Ay), ($Bx,$By), ($Cx,$Cy) forms a triangle" if $verbose;
 
  if $Ax * ($By - $Cy) + $Bx * ($Cy - $Ay) + $Cx * ($Ay - $By)
  {
    say ": trangle detected" if $verbose;
    say False;
    exit
  }
}

say True;

