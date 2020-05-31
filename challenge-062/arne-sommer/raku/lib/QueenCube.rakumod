use v6;

constant ansi-blue  = "\e[44m";
constant ansi-green = "\e[42m";
constant ansi-red   = "\e[101m";
constant ansi-stop  = "\e[0m ";

constant html-blue  = '<span class="text-light bg-primary">';
constant html-green = '<span class="text-light bg-success">';
constant html-red   = '<span class="text-light bg-danger">';
constant html-stop  = '</span> ';


unit class QueenCube;


has Int $.size;
has @.elems is rw;
has $.blank is rw;


method init ($init)
{
  self.blank = $init;

  for 1 .. $!size -> $x
  {
    for 1 .. $!size -> $y
    {
      for 1 .. $!size -> $z
      {
        @.elems[$x; $y; $z] = $init;
      }
    }
  }
}


multi method queen ($id, $x, $y, $z)
{
  die "Blacked out position $x, $y, $z " if @.elems[$x; $y; $z] ne self.blank;
    
  @.elems[$x; $y; $z] = $id;

  my $min      = 1;
  my $max      = self.size;
  my $blackout = $id.lc;
    
  for -1, 0, 1 -> $xx
  {
    for -1, 0, 1 -> $yy
    {
      for -1, 0, 1 -> $zz
      {
        next if $xx == $yy == $zz == 0; # The Queen is here
	
        for (1 .. $max) -> $h
	{
          my $xxx = $x + $xx * $h;
          my $yyy = $y + $yy * $h;
          my $zzz = $z + $zz * $h;
	  next if any($xxx, $yyy, $zzz) < $min;
          next if any($xxx, $yyy, $zzz) > $max;
          @.elems[    $xxx; $yyy; $zzz] = $blackout;
        }
      }
    }
  }
}


multi method queen ($id, $xyz)
{
  my ($x, $y, $z) = $xyz.split(";");
    
  die "Queen position out of range (1 .. { self.size })" if any($x, $y, $z) < 1;
  die "Queen position out of range (1 .. { self.size })" if any($x, $y, $z) > self.size;

  self.queen($id, $x, $y, $z);
}


method display ($colour, $layer-from = 1, $layer-to = self.size)
{
  for 1 .. self.size -> $y
  {
    for $layer-from .. $layer-to -> $x
    {
      for 1 .. self.size -> $z
      {
        if $colour && $colour eq "html"
        {
          given @.elems[$x; $y; $z]
          {
            when self.blank { print html-red   ~ $_ ~ html-stop; }
            when /<[A..Z]>/ { print html-blue  ~ $_ ~ html-stop; }
            when /<[a..z]>/ { print html-green ~ $_ ~ html-stop; }
	  }
	}
        elsif $colour
	{
          given @.elems[$x; $y; $z]
   	  {
	     when self.blank { print ansi-red   ~ $_ ~ ansi-stop; }
	     when /<[A..Z]>/ { print ansi-blue  ~ $_ ~ ansi-stop; }
	     when /<[a..z]>/ { print ansi-green ~ $_ ~ ansi-stop; }
	  }
        }
	else
	{
          print @.elems[$x; $y; $z], " ";
        }
      }
      print "   ";
    }
    say "":
  }
}


method display-with-newlines($colour, $break-after)
{
  my $size  = self.size;
  my $start = 1;
  my $stop  = min($size, $break-after);

  loop
  {
    self.display($colour, $start, $stop);
    $start += $break-after;
    $stop  += $break-after;

    last if $start > $size;
    $stop = min($stop, $size);
    print "\n\n";
  }
}


method number-of-queens
{
  return @!elems[*;*;*].grep({ $_.defined }).grep( * ~~ /<[A..Z]>/ ).elems;
}


method get-empty-cell
{
  for 1 .. self.size -> $x
  {
    for 1 .. self.size -> $y
    {
      for 1 ..self.size -> $z
      { 
        return "$x;$y;$z" if @.elems[$x;$y;$z] eq self.blank;
      }
    }
  }
  return;
}


method get-empty-cell-random
{
  for self.get-all-cells.flat.pick(*) -> $elem
  {
    my ($x, $y, $z) = $elem.split(";");
    return "$x;$y;$z" if @.elems[$x;$y;$z] eq self.blank;
  }
  return;
}


method get-all-cells
{
  my @all;
  for 1 .. self.size -> $x
  {
    for 1 .. self.size -> $y
    {
      for 1 ..self.size -> $z
      {
        @all.push("$x;$y;$z");
      }
    }
  }
  return @all;
}


method cell-is-free ($cell)
{
  my ($x, $y, $z) = $cell.split(";");
  return self.elems[$x;$y;$z] eq self.blank;
}

